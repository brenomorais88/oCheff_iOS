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
    let logo: String?
    let bannerImage: String?
    let rate: String?
    let street: String?
    let streetNumber: String?
    let neighborhood: String?
    let city: String?
    let state: String?
    let priceAverage: String?
    let status: Int?
    let categories: [EstablishmentCategoryResponse]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "shortName"
        case fullName = "fullName"
        case logo = "logoImage"
        case bannerImage = "bannerImager"
        case rate = "rate"
        case street = "street"
        case streetNumber = "streetNumber"
        case neighborhood = "neighborhood"
        case city = "city"
        case state = "state"
        case priceAverage = "averagePrice"
        case status = "status"
        case categories = "categories"
    }
    
    func getCategoriesText() -> String {
        var categoriesText: String = ""
        var index = 1
        
        
        for item in categories ?? [] {
            categoriesText.append(item.name)
            
            if index < categories?.count ?? 0 {
                categoriesText.append(", ")
            }
            index += 1
        }
        return categoriesText
        
    }
    
    func getAddressText() -> String {
        var addressText = ""
        var streetText = ""
        
        if let street = self.street, let streetNumber = self.streetNumber {
            streetText = "\(street), \(streetNumber)"
            addressText.append(streetText)
        }
        
        if let neighborhood = self.neighborhood {
            addressText.append(" - \(neighborhood)")
        }
        
        if let city = self.city {
            addressText.append(" - \(city)")
        }
        
        return addressText
    }
}
