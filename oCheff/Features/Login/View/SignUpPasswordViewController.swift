//
//  SignUpPasswordViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import UIKit

class SignUpPasswordViewController: ViewController {
    @IBOutlet weak var firstPassView: UIView?
    @IBOutlet weak var secondPassView: UIView?
    @IBOutlet weak var firstPassTextField: UITextField?
    @IBOutlet weak var secondPassTextField: UITextField?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupSignUPNav()
    }
    
    private func setupViews() {
        self.firstPassTextField?.delegate = self
        self.secondPassTextField?.delegate = self
    }
    
    @IBAction func showFirstPass(_ sender: Any) {
        self.firstPassTextField?.isSecureTextEntry = !(self.firstPassTextField?.isSecureTextEntry ?? true)
    }
    
    @IBAction func showSecondPass(_ sender: Any) {
        self.secondPassTextField?.isSecureTextEntry = !(self.secondPassTextField?.isSecureTextEntry ?? true)
    }
    
    @IBAction func confirmSignUp(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setRootLoggedUser()
    }
}

extension SignUpPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        firstPassTextField?.superview?.setupNotSelectedTextField()
        secondPassTextField?.superview?.setupNotSelectedTextField()
        textField.superview?.setupSelectedTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.superview?.setupNotSelectedTextField()
    }
}
