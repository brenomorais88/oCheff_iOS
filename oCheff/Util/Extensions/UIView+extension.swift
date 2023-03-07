//
//  UIView+extension.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 17/02/23.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorder() {
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.appLightGray.cgColor
        self.layer.borderWidth = 1.0
    }
    
    func setupSelectedTextField() {
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.primaryColor.cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = UIColor.white
    }
    
    func setupNotSelectedTextField() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.0
        self.backgroundColor = UIColor.appTextFieldViewGray
    }
    
    func setupSecondaryBtn() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.white
    }
    
    func roundTop() {
        let rectShape = CAShapeLayer()
        rectShape.frame = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: [.topLeft , .topRight],
                                      cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
    
    func roundBottom() {
        let rectShape = CAShapeLayer()
        rectShape.frame = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: [.bottomLeft , .bottomRight],
                                      cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
    
    func roundTop(bounds: CGRect) {
        let rectShape = CAShapeLayer()
        rectShape.frame = bounds
        rectShape.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: [.topLeft , .topRight],
                                      cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
    
    func roundBottom(bounds: CGRect) {
        let rectShape = CAShapeLayer()
        rectShape.frame = bounds
        rectShape.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: [.bottomLeft , .bottomRight],
                                      cornerRadii: CGSize(width: 15, height: 15)).cgPath
        self.layer.mask = rectShape
    }
}

