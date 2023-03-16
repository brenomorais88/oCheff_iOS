//
//  ProfileViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation

class ProfileViewModel: ViewModel {
    
    let delegate: ProfileCoordinatorProtocol
    let service: UserService
    
    init(delegate: ProfileCoordinatorProtocol,
         service: UserService) {
        self.delegate = delegate
        self.service = service
        super.init()
    }
    
    func getUserFromPhone(phone: String, callback: @escaping (Bool, User?) -> ()) {
        let params = GetUserFromPhoneRequest(phone: phone.replacingOccurrences(of: "+", with: ""))
        self.service.getUserFromPhone(params: params, callback: callback)
    }
}
