//
//  PhoneValidationViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 18/02/23.
//

import UIKit

class PhoneValidationViewController: ViewController {
    
    @IBOutlet weak var firstTextField: UITextField?
    @IBOutlet weak var secondTextField: UITextField?
    @IBOutlet weak var thirdTextField: UITextField?
    @IBOutlet weak var fourthTextField: UITextField?
    @IBOutlet weak var fifthTextField: UITextField?
    
    @IBOutlet weak var firstViewCode: UIView?
    @IBOutlet weak var secondViewCode: UIView?
    @IBOutlet weak var thirdViewCode: UIView?
    @IBOutlet weak var fourthViewCode: UIView?
    @IBOutlet weak var fifthViewCode: UIView?
    
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
        self.firstTextField?.delegate = self
        self.secondTextField?.delegate = self
        self.thirdTextField?.delegate = self
        self.fourthTextField?.delegate = self
        self.fifthTextField?.delegate = self
        
        self.firstTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.secondTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.thirdTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.fourthTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.fifthTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    
    }

    @IBAction func resentCode(_ sender: Any) {
        
    }
    
    @IBAction func continueSignUp(_ sender: Any) {
        let vc = SignUpPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changeNumber(_ sender: Any) {
        self.backAction()
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
                fifthTextField?.resignFirstResponder()
                
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
