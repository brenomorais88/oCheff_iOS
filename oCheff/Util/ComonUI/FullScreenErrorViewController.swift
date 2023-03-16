//
//  FullScreenErrorViewController.swift
//  oCheff
//
//  Created by Breno Morais on 16/03/23.
//

import UIKit

protocol FullScreenErrorDelegate {
    func didTapFirstButton()
    func didTapSecondButton()
}

extension FullScreenErrorDelegate {
    func didTapSecondButton() {}
}

class FullScreenErrorViewController: ViewController {
    @IBOutlet weak var errorTitle: UILabel?
    @IBOutlet weak var errorMessage: UILabel?
    @IBOutlet weak var firstButton: UIButton?
    @IBOutlet weak var secondaryButton: UIButton?
    
    let titleText: String
    let message: String
    let buttonText: String
    let showSecondaryButton: Bool
    let secondaryButtonText: String
    let delegate: FullScreenErrorDelegate?
    
    init(titleText: String = "Ops!",
         message: String,
         showSecondaryButton: Bool = false,
         buttonText: String = "voltar",
         secondaryButtonText: String = "",
         delegate: FullScreenErrorDelegate?) {
        
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
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupViews() {
        self.errorTitle?.text = self.titleText
        self.errorMessage?.text = self.message
        self.firstButton?.setTitle(self.buttonText, for: .normal)
        
        if self.showSecondaryButton {
            self.secondaryButton?.setTitle(self.secondaryButtonText, for: .normal)
            self.secondaryButton?.setupSecondaryBtn()
            
        } else {
            self.secondaryButton?.removeFromSuperview()
        }
    }
    
    @IBAction func tapFirstButton(_ sender: Any) {
        self.delegate?.didTapFirstButton()
    }
    
    @IBAction func tapSecondButton(_ sender: Any) {
        self.delegate?.didTapSecondButton()
    }
}
