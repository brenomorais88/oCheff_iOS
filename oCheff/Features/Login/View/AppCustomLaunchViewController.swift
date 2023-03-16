//
//  AppCustomLaunchViewController.swift
//  oCheff
//
//  Created by Breno Morais on 15/03/23.
//

import UIKit

class AppCustomLaunchViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    private var service: UserService? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service = UserService()
        self.checkUser()
    }

    private func checkUser() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        guard let currentPhone = Defaults.shared.getSessionPhone() else {
//            appDelegate.setRootNotLoggedUser()
//            return
//        }
//
        let currentPhone = "5511981797687"
        print(currentPhone)
        
        let params = CheckTokenRequest(phone: currentPhone)
        
        self.service?.checkSession(params: params, callback: { userLogged in
            if userLogged {
                appDelegate.setRootLoggedUser()
            } else {
                appDelegate.setRootNotLoggedUser()
            }
        })
    }
}
