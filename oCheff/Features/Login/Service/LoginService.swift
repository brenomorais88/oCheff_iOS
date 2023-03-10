//
//  LoginService.swift
//  oCheff
//
//  Created by Breno Morais on 08/03/23.
//

import Foundation
import Alamofire

protocol LoginServiceProtocol {
    func signIn(completion: (Bool) -> ())
    func signUp(user: CreateUserRequest, callback: (Bool, UserResponse?) -> ())
    func checkSession(completion: (Bool) -> ())
    func logOut(completion: (Bool) -> ())
}

class LoginService: Service {
    override init(delegate: ServiceProtocol?) {
        super.init(delegate: delegate)
    }
}

extension LoginService: LoginServiceProtocol {
    func signIn(completion: (Bool) -> ()) {
        
        let login = Login(email: "test@test.test", password: "testPassword")
        
        AF.request("https://httpbin.org/post",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in
            
            switch response.result {
                case .success:
                    print("Validation Successful")
                
                case let .failure(error):
                    self.handleError(error)
            }
        }
        
        completion(false)
    }
    
    func signUp(user: CreateUserRequest, callback: (Bool, UserResponse?) -> ()) {
        callback(true, nil)
        
//        AF.request("\(self.baseURL)/Users/create",
//                   method: .post,
//                   parameters: user,
//                   encoder: JSONParameterEncoder.default).responseDecodable(of: UserResponse.self) { response in
//
//            switch response.result {
//                case .success:
//                    print("Validation Successful")
//                    callback(true, response.value)
//
//                case let .failure(error):
//                    callback(false, nil)
////                    self.handleError(error)
//            }
//        }
    }
    
    func checkSession(completion: (Bool) -> ()) {
        completion(true)
    }
    
    func logOut(completion: (Bool) -> ()) {
        completion(true)
    }
}


struct Login: Encodable {
    let email: String
    let password: String
}
