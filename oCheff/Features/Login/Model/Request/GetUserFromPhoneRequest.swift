//
//  GetUserFromPhoneRequest.swift
//  oCheff
//
//  Created by Breno Morais on 16/03/23.
//

import Foundation

struct GetUserFromPhoneRequest: Encodable {
    let phone: String
    
    private enum CodingKeys: String, CodingKey {
        case phone = "phoneNumber"
    }
}
