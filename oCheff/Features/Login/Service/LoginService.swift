//
//  LoginService.swift
//  oCheff
//
//  Created by Breno Morais on 08/03/23.
//

import Foundation
import Alamofire

protocol LoginServiceProtocol {
    func signIn(completion: @escaping (Bool) -> ())
    func signUp(user: CreateUserRequest, completion: @escaping (Bool) -> ())
    func checkSession(completion:  @escaping  (Bool) -> ())
    func logOut(completion:  @escaping  (Bool) -> ())
}

class LoginService: Service {
}

extension LoginService: LoginServiceProtocol {
    func signIn(completion: @escaping (Bool) -> ()) {
        
        let login = Login(email: "test@test.test", password: "testPassword")
        
        AF.request("https://httpbin.org/post",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in
            
            switch response.result {
                case .success:
                    print("Validation Successful")
                
                case let .failure(error):
                    print(error)
            }
        }
        
        completion(false)
    }
    
    func signUp(user: CreateUserRequest, completion: @escaping (Bool) -> ()) {
        AF.request("\(self.baseURL)/Users/create",
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: UserResponse.self) { response in

            switch response.result {
                case .success:
                    print("Validation Successful")
                    completion(true)


                case let .failure(error):
                    completion(false)
                    print(error)
            }
        }
    }
    
    func checkSession(completion: @escaping (Bool) -> ()) {
        completion(true)
    }
    
    func logOut(completion: @escaping (Bool) -> ()) {
        completion(true)
    }
}


struct Login: Encodable {
    let email: String
    let password: String
}
