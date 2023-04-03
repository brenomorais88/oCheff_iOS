//
//  CreateUserRequest.swift
//  oCheff
//
//  Created by Breno Morais on 16/03/23.
//

import Foundation
import UIKit

struct CreateUserRequest: Encodable {
    let userType: Int = 1
    let device: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let name: String
    let surName: String
    let phone: String
    let email: String
    let document: String
    let photo: String
    let fbKey: String
    let ggKey: String
    
    init(name: String,
         surName: String,
         phone: String,
         email: String,
         document: String = "",
         photo: String = "",
         fbKey: String = "",
         ggKey: String = "") {
        
        self.name = name
        self.surName = surName
        self.phone = phone
        self.email = email
        self.document = document
        self.photo = photo
        self.ggKey = ggKey
        self.fbKey = fbKey
    }
    
    private enum CodingKeys: String, CodingKey {
        case userType = "type" 
        case device = "device"
        case name = "name"
        case surName = "surname"
        case phone = "phoneNumber"
        case email = "email"
        case document = "document"
        case photo = "photo"
        case fbKey = "facebookKey"
        case ggKey = "googleKey"
    }
}
