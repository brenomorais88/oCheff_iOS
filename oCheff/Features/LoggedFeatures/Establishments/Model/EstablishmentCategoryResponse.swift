//
//  EstablishmentCategoryResponse.swift
//  oCheff
//
//  Created by Breno Morais on 13/03/23.
//

import Foundation

struct EstablishmentCategoryResponse: Decodable {
    let id: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
