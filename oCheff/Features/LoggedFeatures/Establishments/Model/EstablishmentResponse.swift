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
    
//    let image: Data?
//    let bannerImage: Data?
//    let rate: String?
//    let street: String?
//    let streetNumber: String?
//    let neighborhood: String?
//    let city: String?
//    let state: String?
//    let latitude: Double?
//    let longitude: Double?
//    let priceAverage: String?
//    let status: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name = "shortName"
        case fullName = "fullName"
//        case distance
//        case avaliation
//        case image
    }
}
