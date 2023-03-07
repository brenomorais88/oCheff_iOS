//
//  SignUpViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 17/02/23.
//

import UIKit

class SignUpViewController: ViewController {
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var secondNameTextField: UITextField?
    @IBOutlet weak var phoneTextField: UITextField?
    @IBOutlet weak var mailTextField: UITextField?
    @IBOutlet weak var googleView: UIView?
    @IBOutlet weak var fbView: UIView?
    
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
        self.setupSignUPNav()
    }
    
    private func setupViews() {
        googleView?.addBorder()
        fbView?.addBorder()
        
        nameTextField?.delegate = self
        secondNameTextField?.delegate = self
        phoneTextField?.delegate = self
        mailTextField?.delegate = self
    }

    @IBAction func signUp(_ sender: Any) {
        let vc = PhoneValidationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        phoneTextField?.superview?.setupNotSelectedTextField()
        mailTextField?.superview?.setupNotSelectedTextField()
        textField.superview?.setupSelectedTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.superview?.setupNotSelectedTextField()
    }
}

