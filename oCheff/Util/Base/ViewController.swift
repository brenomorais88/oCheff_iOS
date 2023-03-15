//
//  BaseViewController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    let loadingVC = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.viewsBackgroundColor
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.backgroundColor = UIColor.white
    }
    
    func showCurrentTable(delegate: HomeCoordinatorProtocol) {
        let viewModel = CurrentTableViewModel(delegate: delegate)
        let vc = CurrentTableViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showWarning(titleText: String,
                     message: String,
                     showSecondaryButton: Bool = false,
                     buttonText: String = "Continuar",
                     secondaryButtonText: String = "",
                     delegate: WarningProtocol) {
        
        let vc = WarningViewController(titleText: titleText,
                                       message: message,
                                       showSecondaryButton: showSecondaryButton,
                                       buttonText: buttonText,
                                       secondaryButtonText: secondaryButtonText,
                                       delegate: delegate)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingVC.modalPresentationStyle = .overFullScreen
            self.loadingVC.modalTransitionStyle = .crossDissolve
            self.present(self.loadingVC, animated: true, completion: nil)
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.loadingVC.dismiss(animated: true)
        }
    }
}
