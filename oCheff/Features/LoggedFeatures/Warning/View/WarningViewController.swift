//
//  WarningViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 25/02/23.
//

import UIKit

protocol WarningProtocol {
    func didTapContinueButton()
    func didTapSecondaryButton()
}

class WarningViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var textLabel: UILabel?
    @IBOutlet weak var secondaryButton: UIButton?
    @IBOutlet weak var continueButton: UIButton?
    
    let titleText: String
    let message: String
    let showSecondaryButton: Bool
    let buttonText: String
    let secondaryButtonText: String
    let delegate: WarningProtocol
    
    init(titleText: String, message: String, showSecondaryButton: Bool = false, buttonText: String = "Continuar", secondaryButtonText: String = "", delegate: WarningProtocol) {
        
        self.titleText = titleText
        self.message = message
        self.showSecondaryButton = showSecondaryButton
        self.buttonText = buttonText
        self.secondaryButtonText = secondaryButtonText
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupView() {
        self.titleLabel?.text = self.titleText
        self.textLabel?.text = self.message
        self.continueButton?.setTitle(self.buttonText, for: .normal)
        
        if self.showSecondaryButton {
            self.secondaryButton?.setTitle(self.secondaryButtonText, for: .normal)
            self.secondaryButton?.setupSecondaryBtn()
        
        } else {
            self.secondaryButton?.removeFromSuperview()
        }
    }
    
    //MARK: actions
    
    @IBAction func didTapSecondaryButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate.didTapSecondaryButton()
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate.didTapContinueButton()
    }
}
