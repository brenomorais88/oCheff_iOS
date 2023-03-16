//
//  SignUpViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 17/02/23.
//

import UIKit
import Alamofire

class SignUpViewController: ViewController {
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var secondNameTextField: UITextField?
    @IBOutlet weak var mailTextField: UITextField?
    @IBOutlet weak var googleView: UIView?
    @IBOutlet weak var fbView: UIView?
    
    private var service: UserService? = nil
    var phone: String? = nil
    
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
        googleView?.addBorder()
        fbView?.addBorder()
        
        nameTextField?.delegate = self
        secondNameTextField?.delegate = self
        mailTextField?.delegate = self
    }
    
    private func createUserModel() -> CreateUserRequest? {
        guard let name = self.nameTextField?.text,
              let surName = self.secondNameTextField?.text,
              let mail = self.mailTextField?.text,
              let phone = self.phone?.clearPhoneString() else {
            return nil
        }
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let user = CreateUserRequest(deviceID: deviceID,
                                     name: name,
                                     surName: surName,
                                     phone: "55\(phone)",
                                     email: mail)
        
        return user
    }
    
    private func signUp() {
        guard let user = self.createUserModel() else {
            return
        }
        
        self.service?.signUp(params: user, callback: { created  in
            if created {
                self.getSessionToken(phone: user.phone)
                
            } else {
                print("Show Error")
            }
        })
    }
    
    private func getSessionToken(phone: String) {
        let params = CheckTokenRequest(phone: phone)
        
        self.service?.checkSession(params: params, callback: { success in
            if success {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setRootLoggedUser()
                Defaults.shared.saveSessionPhone(phone: phone)
                
            } else {
                print("Show Error")
            }
        })
    }
    
    //MARK: actions

    @IBAction func signUp(_ sender: Any) {
        self.signUp()
    }
    
    @IBAction func ggSignUp(_ sender: Any) {
    }
    
    @IBAction func fbSignUp(_ sender: Any) {
    }
    
    @IBAction func signIn(_ sender: Any) {
        self.backAction()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextField?.superview?.setupNotSelectedTextField()
        secondNameTextField?.superview?.setupNotSelectedTextField()
        mailTextField?.superview?.setupNotSelectedTextField()
        textField.superview?.setupSelectedTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.superview?.setupNotSelectedTextField()
    }
}
