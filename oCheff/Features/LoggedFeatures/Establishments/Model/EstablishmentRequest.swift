//
//  EstablishmentRequest.swift
//  oCheff
//
//  Created by Breno Morais on 15/03/23.
//

import Foundation

struct EstablishmentRequest: Encodable {
    let userLatitude: Double?
    let userLongitute: Double?
    let distance: Int?
    let averagePrice: Double?
    let category: Int?
    let pageNumber: Int
    let pageSize: Int
    
    private enum CodingKeys: String, CodingKey {
        case userLatitude = "UserLatitude"
        case userLongitute = "UserLongitute"
        case distance = "Distance"
        case averagePrice = "AveragePrice"
        case category = "Category"
        case pageNumber = "PageNumber"
        case pageSize = "PageSize"
    }
}

struct EstablishmentFilter {
    let distance: Int?
    let averagePrice: Double?
}
