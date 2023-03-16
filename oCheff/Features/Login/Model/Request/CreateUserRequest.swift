//
//  CreateUserRequest.swift
//  oCheff
//
//  Created by Breno Morais on 16/03/23.
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
    
    init(userType: String = "1",
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
}
