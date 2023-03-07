//
//  Double+extension.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 24/02/23.
//

import Foundation

extension Double {
    func toCurrency() -> String? {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        
        } else {
            return nil
        }
    }
}
