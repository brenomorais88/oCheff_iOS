//
//  UpdateUserRequest.swift
//  oCheff
//
//  Created by Breno Morais on 17/03/23.
//

import Foundation
import UIKit

struct UpdateUserRequest: Encodable {
    let id: String
    let device: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let name: String
    let surName: String
    let email: String
    let document: String?
    let photo: String?
    let ggKey: String?
    let fbKey: String?
    
    init(id: String,
         name: String,
         surName: String,
         email: String,
         document: String,
         photo: String,
         ggKey: String,
         fbKey: String?) {
        
        self.id = id
        self.name = name
        self.surName = surName
        self.email = email
        self.document = document
        self.photo = photo
        self.ggKey = ggKey
        self.fbKey = fbKey
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case surName = "surname"
        case email = "email"
        case document = "document"
        case photo = "photo"
        case ggKey = "googleKey"
        case fbKey = "facebookKey"
    }
}
