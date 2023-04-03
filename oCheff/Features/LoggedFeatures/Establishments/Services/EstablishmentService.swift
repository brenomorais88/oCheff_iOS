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
    func getEstablishmentsDetail(id: Int, callback: @escaping (Bool, EstablishmentResponse?) -> ())
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
    
    func getEstablishmentsDetail(id: Int,
                                 callback: @escaping (Bool, EstablishmentResponse?) -> ()) {
        
        AF.request("\(self.baseURL)/Restaurants/\(id)",
                   method: .get,
                   encoding: URLEncoding.httpBody).response { response in

            switch response.result {
                case .success:
                do {
                    let parsedData = try self.decoder.decode(EstablishmentResponse.self,
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

                case .failure:
                    callback(false, nil)
            }
        }
    }
}
