//
//  CheckTokenRequest.swift
//  oCheff
//
//  Created by Breno Morais on 16/03/23.
//

import Foundation
import UIKit

struct CheckTokenRequest: Encodable {
    let phone: String
    let device: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    private enum CodingKeys: String, CodingKey {
        case phone = "phoneNumber"
        case device = "device"
    }
}
