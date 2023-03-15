//
//  EstablishmentResponse.swift
//  oCheff
//
//  Created by Breno Morais on 13/03/23.
//

import Foundation

struct EstablishmentResponse: Decodable {
    let id: Int
    let name: String?
    let fullName: String?
//    let distance: String?
//    let avaliation: String?
//    let image: Data?
    let registerNumber: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case registerNumber = "registrationNumber"
        case name = "shortName"
        case fullName = "fullName"
//        case distance
//        case avaliation
//        case image
    }
    
//    "id": 1,
//        "registrationNumber": "231231231",
//        "shortName": "REST 1",
//        "fullName": "REST 1 231312321"
}
