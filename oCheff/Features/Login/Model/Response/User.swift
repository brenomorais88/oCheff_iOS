//
//  User.swift
//  oCheff
//
//  Created by Breno Morais on 09/03/23.
//

import Foundation

struct User: Decodable {
    let id: Int
    let userType: Int?
    let deviceID: String?
    let name: String?
    let surName: String?
    let phone: String?
    let email: String?
    let document: String?
    let photo: String?
    let ggKey: String?
    let fbKey: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
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
