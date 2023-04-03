//
//  ProfileViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation
import UIKit

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
    
    func saveUserImage(image: UIImage, callback: @escaping (Bool) -> ()) {
        guard let imgString = image.resizeWithWidth(width: 100)?.toBase64String() else {
            return
        }
        
        let params = UpdateUserImageRequest(image: imgString)
        self.service.updateUserImage(params: params, callback: callback)
    }
    
    func deleteUserImage(callback: @escaping (Bool) -> ()) {
        #warning("corrigir api para enviar uma string vazia quando for deletar a foto")
        let params = UpdateUserImageRequest(image: "empty")
        self.service.updateUserImage(params: params, callback: callback)
    }
    
    func logOut() {
        self.service.logOut { success in
            if success {
                print("usuario deslogado")
            }
        }
    }
}
