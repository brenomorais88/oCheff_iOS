//
//  AppCustomLaunchViewController.swift
//  oCheff
//
//  Created by Breno Morais on 15/03/23.
//

import UIKit

class AppCustomLaunchViewController: UIViewController {
    private var service: LoginService? = nil
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = LoginService()
        self.checkUser()
    }

    private func checkUser() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.service?.checkSession(completion: { userLogged in
            if userLogged {
                appDelegate.setRootLoggedUser()
            } else {
                appDelegate.setRootNotLoggedUser()
            }
        })
    }
}
