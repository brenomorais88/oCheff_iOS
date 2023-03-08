//
//  UIButton+extension.swift
//  oCheff
//
//  Created by Breno Morais on 07/03/23.
//

import UIKit

extension UIButton {
//    func setupPrimaryBtn() {
//        self.layer.masksToBounds = true
//        self.backgroundColor = UIColor.primaryBtnBackGroundColor
//        self.
//    }
    
    func setupSecondaryBtn() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.white
    }
    
}
