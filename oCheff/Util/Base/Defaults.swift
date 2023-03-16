//
//  Defaults.swift
//  oCheff
//
//  Created by Breno Morais on 15/03/23.
//

import Foundation

enum DefaulsKeys: String {
    case phoneKey = "currentUserPhone"
    case tokenKey = "currentSessionToken"
}

class Defaults: UserDefaults {
    static let shared = Defaults()
    
    
    //MARK: userPhone
    func saveSessionPhone(phone: String) {
        UserDefaults.standard.set(phone,
                                  forKey: DefaulsKeys.phoneKey.rawValue)
    }
    
    func getSessionPhone() -> String? {
        let key = DefaulsKeys.phoneKey.rawValue
        
        if let sessionPhone = UserDefaults.standard.string(forKey: key), sessionPhone != "" {
            return sessionPhone
            
        } else {
            return nil
        }
    }
    
    func cleanSessionPhone() {
        let key = DefaulsKeys.phoneKey.rawValue
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    //MARK: userTOKEN
    func saveSessionToken(token: String) {
        UserDefaults.standard.set(token,
                                  forKey: DefaulsKeys.tokenKey.rawValue)
    }
    
    func getSessionToken() -> String? {
        let key = DefaulsKeys.tokenKey.rawValue
        
        if let sessionToken = UserDefaults.standard.string(forKey: key), sessionToken != "" {
            return sessionToken
            
        } else {
            return nil
        }
    }
}
