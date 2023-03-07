//
//  LoginViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 17/02/23.
//

import UIKit

class LoginViewController: ViewController {
    @IBOutlet weak var googleView: UIView?
    @IBOutlet weak var fbView: UIView?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        self.emailTextField?.delegate = self
        self.passwordTextField?.delegate = self
        
        googleView?.addBorder()
        fbView?.addBorder()
    }
    
    // MARK: Actions
    
    @IBAction func showPassword(_ sender: Any) {
        self.passwordTextField?.isSecureTextEntry = !(self.passwordTextField?.isSecureTextEntry ?? true)
    }
    
    @IBAction func rememberPassword(_ sender: Any) {
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootLoggedUser()
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
    }
    
    @IBAction func fbSignIn(_ sender: Any) {
    }
    
    @IBAction func newAccount(_ sender: Any) {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField?.superview?.setupNotSelectedTextField()
        passwordTextField?.superview?.setupNotSelectedTextField()
        textField.superview?.setupSelectedTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.superview?.setupNotSelectedTextField()
    }
}
