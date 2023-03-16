//
//  UserToken.swift
//  oCheff
//
//  Created by Breno Morais on 16/03/23.
//

import Foundation

struct UserToken: Decodable {
    let token: String
    let user: User?
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }
}
