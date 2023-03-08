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
    func signUp(completion: (Bool) -> ())
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
    
    func signUp(completion: (Bool) -> ()) {
        completion(true)
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
