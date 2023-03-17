//
//  PhoneValidationViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import UIKit
import Firebase
import FirebaseAuth
import Alamofire

class PhoneValidationViewController: ViewController {
    
    @IBOutlet weak var firstTextField: UITextField?
    @IBOutlet weak var secondTextField: UITextField?
    @IBOutlet weak var thirdTextField: UITextField?
    @IBOutlet weak var fourthTextField: UITextField?
    @IBOutlet weak var fifthTextField: UITextField?
    @IBOutlet weak var sixthTextField: UITextField?
    
    @IBOutlet weak var firstViewCode: UIView?
    @IBOutlet weak var secondViewCode: UIView?
    @IBOutlet weak var thirdViewCode: UIView?
    @IBOutlet weak var fourthViewCode: UIView?
    @IBOutlet weak var fifthViewCode: UIView?
    @IBOutlet weak var sixthViewCode: UIView?
    @IBOutlet weak var phoneText: UILabel?
    
    var phone: String? = nil
    private var service: UserService? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.service = UserService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupSignUPNav()
    }
    
    private func setupViews() {
        self.firstTextField?.delegate = self
        self.secondTextField?.delegate = self
        self.thirdTextField?.delegate = self
        self.fourthTextField?.delegate = self
        self.fifthTextField?.delegate = self
        self.sixthTextField?.delegate = self
        
        self.firstTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.secondTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.thirdTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.fourthTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.fifthTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.sixthTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        if let phone = self.phone {
            self.phoneText?.text = "Preencha com o código enviado para o telefone preenchido \(phone)"
        }
    }
    
    func getValidationCode() -> String? {
        guard let code1 = self.firstTextField?.text,
              let code2 = self.secondTextField?.text,
              let code3 = self.thirdTextField?.text,
              let code4 = self.fourthTextField?.text,
              let code5 = self.fifthTextField?.text,
              let code6 = self.sixthTextField?.text else {
            
            return nil
        }
        
        let code = code1 + code2 + code3 + code4 + code5 + code6
        
        if code.count == 6 {
            return code
        }
        
        return nil
    }
    
    private func signIn(verificationCode: String) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        self.showLoading()
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
              let authError = error as NSError
                self.userLoginError(authError: authError)
              return
            }
            self.codeValidationOK()
        }
    }
    
    private func codeValidationOK() {
        checkIfUserExists()
    }
    
    private func checkIfUserExists() {
        let phone = "55\(self.phone?.clearPhoneString() ?? "")"
        let params = GetUserFromPhoneRequest(phone: phone)
        
        self.service?.getUserFromPhone(params: params,
                                       callback: { userExists, user in
            if userExists, let id = user?.id {
                self.updateUserDevice(id: id, phone: phone)
                
            } else {
                self.dismissLoading()
                self.showSignUp()
            }
        })
    }
    
    private func updateUserDevice(id: Int, phone: String) {
        let params = UpdateUserDeviceRequest(id: id, phone: phone)
        
        self.service?.updateUserDevice(params: params, callback: { succsess in
            if succsess {
                self.getSessionToken(phone: phone)
            } else {
                self.showFullScreenError(delegate: self)
            }
        })
    }
    
    private func getSessionToken(phone: String) {
        let params = CheckTokenRequest(phone: phone)
        
        self.service?.checkSession(params: params, callback: { succsess in
            if succsess {
                Defaults.shared.saveSessionPhone(phone: phone)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setRootLoggedUser()
                
            } else {
                self.showFullScreenError(delegate: self)
            }
        })
    }
    
    func showSignUp() {
        let vc = SignUpViewController()
        vc.phone = self.phone
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func userLoginError(authError: NSError) {
        self.dismissLoading()
       
//        let isMFAEnabled = false
//        if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
        if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
          // The user is a multi-factor user. Second factor challenge is required.
          let resolver = authError
            .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
          var displayNameString = ""
          for tmpFactorInfo in resolver.hints {
            displayNameString += tmpFactorInfo.displayName ?? ""
            displayNameString += " "
          }
          self.showTextInputPrompt(
            message: "Select factor to sign in\n\(displayNameString)",
            completionBlock: { userPressedOK, displayName in
              var selectedHint: PhoneMultiFactorInfo?
              for tmpFactorInfo in resolver.hints {
                if displayName == tmpFactorInfo.displayName {
                  selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                }
              }
              PhoneAuthProvider.provider()
                .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                                   multiFactorSession: resolver
                                     .session) { verificationID, error in
                  if error != nil {
                    print(
                      "Multi factor start sign in failed. Error: \(error.debugDescription)"
                    )
                  } else {
                    self.showTextInputPrompt(
                        message: "Verification code for \(selectedHint?.displayName ?? "")",
                      completionBlock: { userPressedOK, verificationCode in
                        let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                          .credential(withVerificationID: verificationID!,
                                      verificationCode: verificationCode)
                        let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                          .assertion(with: credential!)
                        resolver.resolveSignIn(with: assertion!) { authResult, error in
                          if error != nil {
                            print(
                              "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                            )
                          } else {
                            self.navigationController?.popViewController(animated: true)
                          }
                        }
                      }
                    )
                  }
                }
            }
          )
        } else {
            self.showFullScreenError(delegate: self)
          return
        }
    }
    
    
    func showTextInputPrompt(message: String, completionBlock: (Bool, String) -> ()) {
        print(message)
        completionBlock(true, "")
    }
    
    //MARK: actions

    @IBAction func resentCode(_ sender: Any) {
        
    }
    
    @IBAction func continueSignUp(_ sender: Any) {
        guard let text = self.getValidationCode() else {
            self.showWarning(titleText: "Atenção",
                             message: "Preencha com o código enviado ao seu celular",
                             delegate: self)
            return
        }
        
        self.signIn(verificationCode: text)
    }
    
    @IBAction func changeNumber(_ sender: Any) {
        self.backAction()
    }
}

extension PhoneValidationViewController: WarningProtocol {
    func didTapContinueButton() {
        
    }
    
    func didTapSecondaryButton() {
        
    }
}

extension PhoneValidationViewController: UITextFieldDelegate {
 
    @objc
    func textFieldDidChange(textField: UITextField){

        let textCount = textField.text?.count ?? 0

        if  textCount >= 1 {
            switch textField{
            case firstTextField:
                secondTextField?.becomeFirstResponder()
                
            case secondTextField:
                thirdTextField?.becomeFirstResponder()
                
            case thirdTextField:
                fourthTextField?.becomeFirstResponder()
                
            case fourthTextField:
                fifthTextField?.becomeFirstResponder()
                
            case fifthTextField:
                sixthTextField?.becomeFirstResponder()
                
            case sixthTextField:
                sixthTextField?.resignFirstResponder()
                
            default:
                break
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        firstTextField?.superview?.setupNotSelectedTextField()
        secondTextField?.superview?.setupNotSelectedTextField()
        thirdTextField?.superview?.setupNotSelectedTextField()
        fourthTextField?.superview?.setupNotSelectedTextField()
        fifthTextField?.superview?.setupNotSelectedTextField()
        textField.superview?.setupSelectedTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.superview?.setupNotSelectedTextField()
    }
}
