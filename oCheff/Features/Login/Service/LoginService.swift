//
//  UserService.swift
//  oCheff
//
//  Created by Breno Morais on 08/03/23.
//

import Foundation
import Alamofire

protocol UserServiceProtocol {
    func updateUserDevice(params: UpdateUserDeviceRequest, callback: @escaping (Bool) -> ())
    func updateUserImage(params: UpdateUserImageRequest, callback: @escaping (Bool) -> ())
    func signUp(params: CreateUserRequest, callback: @escaping (Bool, User?) -> ())
    func getUserFromPhone(params: GetUserFromPhoneRequest, callback: @escaping (Bool, User?) -> ())
    func checkSession(params: CheckTokenRequest, callback:  @escaping  (Bool) -> ())
    func logOut(callback:  @escaping  (Bool) -> ())
}

class UserService: Service {
    
}

extension UserService: UserServiceProtocol {
    // Valida se o deviceID e o phone combinam e gera o token
    func checkSession(params: CheckTokenRequest, callback: @escaping (Bool) -> ()) {
        AF.request("\(self.baseURL)/Authentication/create/userToken",
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in

            switch response.result {
            case .success:
                do {
                    let parsedData = try self.decoder.decode(UserToken.self,
                                                             from: response.data ?? Data())
                    
                    Defaults.shared.saveSessionToken(token: parsedData.token)
                    Defaults.shared.saveUserId(id: parsedData.user.id)
                    
                    callback(true)

                } catch {
                    Defaults.shared.cleanSessionPhone()
                    callback(false)
                }
                
            case .failure:
                Defaults.shared.cleanSessionPhone()
                callback(false)
            }
        }
    }
    
    //cadastro de novo usuario
    func signUp(params: CreateUserRequest, callback: @escaping (Bool, User?) -> ()) {
        AF.request("\(self.baseURL)/Users/create",
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in

            switch response.result {
            case .success:
                do {
                    let parsedData = try self.decoder.decode(User.self,
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
    
    func getUserFromPhone(params: GetUserFromPhoneRequest, callback: @escaping (Bool, User?) -> ()) {
        AF.request("\(self.baseURL)/Users/GetByPhoneNumber",
                   method: .get,
                   parameters: params,
                   encoder: URLEncodedFormParameterEncoder.default).response { response in

            switch response.result {
            case .success:
                do {
                    let parsedData = try self.decoder.decode(User.self,
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
    
    // faz login para um usuario ja existente atualizando a combinacao de deviceid + phone
    func updateUserDevice(params: UpdateUserDeviceRequest, callback: @escaping (Bool) -> ()) {
        AF.request("\(self.baseURL)/Users/update",
                   method: .patch,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in

            switch response.result {
            case .success:
                callback(true)

            case .failure:
                callback(false)
            }
        }
    }
    
    //update na imagem do user
    func updateUserImage(params: UpdateUserImageRequest, callback: @escaping (Bool) -> ()) {
        AF.request("\(self.baseURL)/Users/update",
                   method: .patch,
                   parameters: params,
                   encoder: JSONParameterEncoder.default).response { response in

            switch response.result {
            case .success:
                callback(true)

            case .failure:
                callback(false)
            }
        }
    }
    
    //faz logout
    func logOut(callback: @escaping (Bool) -> ()) {
        
    }
}
