//
//  UIViewController+extension.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 17/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupBackButton(color: UIColor = .black) {
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_back_btn"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backAction))
        navigationItem.leftBarButtonItem?.tintColor = color
    }
    
    @objc
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupRightLogo() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"logo_1"), for: .normal)

        let rightBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 75)
        currWidth?.isActive = true
        let currHeight = rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 20)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryColor
    }
    
    func setupFavoriteButtom() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 18, height: 23)
        menuBtn.setImage(UIImage(named:"icon_favorite"), for: .normal)
        menuBtn.addTarget(self, action: #selector(tapFavoriteIcon), for: .touchUpInside)

        let rightBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 75)
        currWidth?.isActive = true
        let currHeight = rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 20)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.primaryColor
    }
    
    func setupTranslucentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupSignUPNav() {
        self.navigationController?.isNavigationBarHidden = false
        setupBackButton()
        setupRightLogo()
    }
    
    @objc
    func tapFavoriteIcon() {
        // need be override
    }
}
