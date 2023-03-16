//
//  LoginPhoneViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 17/02/23.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class LoginPhoneViewController: ViewController {
    @IBOutlet weak var googleView: UIView?
    @IBOutlet weak var fbView: UIView?
    @IBOutlet weak var signInBtn: UIButton?
    @IBOutlet weak var phoneTextField: UITextField?
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        self.phoneTextField?.delegate = self
        googleView?.addBorder()
        fbView?.addBorder()
    }
    
    private func sendValidationCode() {
        guard let text = self.phoneTextField?.text else {
            return
        }
        
        self.showLoading()
        
        let phone = "+55\(text.clearPhoneString())"
        Auth.auth().languageCode = "br"
        
        let provider = PhoneAuthProvider.provider()
        
        provider.verifyPhoneNumber(phone,
                                   uiDelegate: nil) { verificationID, error in
            
            self.dismissLoading()
            
            if error != nil {
                self.showFullScreenError(message: "Erro no login com o Google",
                                         delegate: self)
              return
            }
            
            guard let phone = self.phoneTextField?.text else { return }
            
            UserDefaults.standard.set(verificationID,
                                      forKey: "authVerificationID")
            
            let vc = PhoneValidationViewController()
            vc.phone = phone
            self.navigationController?.pushViewController(vc, animated: true)
          }
    }
    
    private func getGGCredential() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if error != nil {
                self.showFullScreenError(message: "Erro no login com o Google",
                                         delegate: self)
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self.showFullScreenError(message: "Erro no login com o Google",
                                         delegate: self)
                return
            }
            
            let userToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: userToken)
            self.doGGLogin(credential: credential)
        }
    }
    
    func doGGLogin(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { result, error in
            if error != nil {
                self.showFullScreenError(message: "Erro no login com o Google",
                                         delegate: self)
                return
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func signIn(_ sender: Any) {
        if self.phoneTextField?.text?.count ?? 0 < 15 {

            self.showWarning(titleText: "Atenção",
                             message: "preencha um numero de celular válido",
                             delegate: self)
            return
        }

        sendValidationCode()
    }
    
    @IBAction func ggButtonTapped(_ sender: Any) {
        self.getGGCredential()
    }
    
    @IBAction func fbButtonTapped(_ sender: Any) {
    }
}

extension LoginPhoneViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneTextField?.superview?.setupSelectedTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.superview?.setupNotSelectedTextField()
    }
    
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) #####-####"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:  String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedNumber(number: newString)
        return false
    }
}

extension LoginPhoneViewController: WarningProtocol {
    func didTapContinueButton() {
        
    }
    
    func didTapSecondaryButton() {
        
    }
}
