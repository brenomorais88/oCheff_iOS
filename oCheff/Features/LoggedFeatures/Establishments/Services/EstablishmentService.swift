//
//  EstablishmentService.swift
//  oCheff
//
//  Created by Breno Morais on 13/03/23.
//

import Foundation
import Alamofire

protocol EstablishmentServiceProtocol {
    func getEstablishmentCategory(callback: @escaping (Bool, [EstablishmentCategoryResponse]?) -> ())
    func getNearEstablishments(params: EstablishmentRequest, callback: @escaping (Bool, [EstablishmentResponse]?) -> ())
    func getFavoritesEstablishments(callback: (Bool, [EstablishmentResponse]?) -> ())
}

class EstablishmentService: Service {
   
    
}

extension EstablishmentService: EstablishmentServiceProtocol {
    func getNearEstablishments(params: EstablishmentRequest, callback: @escaping (Bool, [EstablishmentResponse]?) -> ()) {
        AF.request("\(self.baseURL)/Restaurants",
                   method: .get,
                   parameters: params,
                   encoder: URLEncodedFormParameterEncoder.default).response { response in

            switch response.result {
                case .success:
                do {
                    let parsedData = try self.decoder.decode([EstablishmentResponse].self,
                                                             from: response.data ?? Data())
                    callback(true, parsedData)
                    
                } catch {
                    callback(false, nil)
                }

                case .failure:
                    callback(false, nil)
            }
        }
    }
    
    func getFavoritesEstablishments(callback: (Bool, [EstablishmentResponse]?) -> ()) {
//        let estList = [
////            EstablishmentResponse(name: "Black Sushi", distance: "1km", avaliation: "4.8", image: Data()),
////            EstablishmentResponse(name: "Pizza Hut", distance: "2km", avaliation: "3.8", image: Data())
//        ]
//
//        callback(true, estList)
    }
    
    func getEstablishmentCategory(callback: @escaping (Bool, [EstablishmentCategoryResponse]?) -> ()) {
        AF.request("\(self.baseURL)/Restaurants/Categories",
                   method: .get,
                   encoding: URLEncoding.httpBody).response { response in

            switch response.result {
                case .success:
                    do {
                        let parsedData = try self.decoder.decode([EstablishmentCategoryResponse].self,
                                                                 from: response.data ?? Data())
                        callback(true, parsedData)
                        
                    } catch {
                        callback(false, nil)
                    }

                case let .failure:
                    callback(false, nil)
            }
        }
    }
}
