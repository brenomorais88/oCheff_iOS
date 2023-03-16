//
//  Service.swift
//  oCheff
//
//  Created by Breno Morais on 08/03/23.
//

import Foundation
import Alamofire

class Service {
    let baseURL: String = "http://webapi.app.br.iron.hostazul.com.br/api/v1"
    let decoder = JSONDecoder()
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    init() {
        
    }
}
