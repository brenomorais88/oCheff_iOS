//
//  UIColor+Extension.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 17/02/23.
//

import Foundation
import UIKit

extension UIColor {
    
    //MARK: Cores
    
    static var appLightGray: UIColor {
        return UIColor.colorFromHex("#E5E7EB")
    }
    
    static var appTextFieldViewGray: UIColor {
        return UIColor.colorFromHex("#F9FAFB")
    }
    
    static var primaryColor: UIColor {
        return UIColor.colorFromHex("#EA2D5A")
    }
    
    static var textGray: UIColor {
        return UIColor.colorFromHex("#6B7280")
    }
    
    static var viewsBackgroundColor: UIColor {
        return UIColor.white
    }
    
    static var primaryBtnBackGroundColor: UIColor {
        return UIColor.black
    }
    
    //MARK: Util
    
    static func colorFromHex(_ hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
