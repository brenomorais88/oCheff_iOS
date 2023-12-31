//
//  UpdateUserDeviceRequest.swift
//  oCheff
//
//  Created by Breno Morais on 17/03/23.
//

import Foundation
import UIKit

struct UpdateUserDeviceRequest: Encodable {
    let id: Int
    let device: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let phone: String?
    
    init(id: Int,
         phone: String) {
        
        self.id = id
        self.phone = phone
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case phone = "phoneNumber"
        case device = "device"
    }
}

struct UpdateUserImageRequest: Encodable {
    let id: Int = Defaults.shared.getUserID()
    let image: String
    
    init(image: String) {
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "photo"
    }
}

