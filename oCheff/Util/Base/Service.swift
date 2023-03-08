//
//  Service.swift
//  oCheff
//
//  Created by Breno Morais on 08/03/23.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    func handleError(_ error: AFError)
}

class Service {
    let baseURL: String = ""
    let delegate: ServiceProtocol?
    
    init(delegate: ServiceProtocol?) {
        self.delegate = delegate
    }
    
    func handleError(_ error: AFError) {
        self.delegate?.handleError(error)
    }
}
