//
//  User.swift
//  oCheff
//
//  Created by Breno Morais on 09/03/23.
//

import Foundation

struct CreateUserRequest: Encodable {
    let userType: String
    let deviceID: String
    let name: String
    let surName: String
    let phone: String
    let email: String
    let document: String?
    let photo: String?
    let ggKey: String?
    let fbKey: String?
    
    init(userType: String = "0",
         deviceID: String,
         name: String,
         surName: String,
         phone: String,
         email: String,
         document: String? = nil,
         photo: String? = nil,
         ggKey: String? = nil,
         fbKey: String? = nil) {
        
        self.userType = userType
        self.deviceID = deviceID
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
        case deviceID = "device"
        case name = "name"
        case surName = "surname"
        case phone = "phoneNumber"
        case email = "email"
        case document = "document"
        case photo = "photo"
        case ggKey = "googleKey"
        case fbKey = "facebookKey"
    }
    
//    {
//      "type": 0,
//      "device": "string",
//      "name": "string",
//      "surname": "string",
//      "phoneNumber": 0,
//      "email": "string",
//      "document": "string",
//      "photo": "string",
//      "facebookKey": "string",
//      "googleKey": "string"
//    }
}

struct UserResponse: Decodable {
    let email: String
    let password: String
}

struct User {
    let email: String
    let password: String
}
