//
//  ProfileCoordinator.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation

protocol ProfileCoordinatorProtocol {
    func ok()
}

class ProfileCoordinator: Coordinator {
    
    override func didInit() {
        let service = UserService()
        let viewModel = ProfileViewModel(delegate: self, service: service)
        self.viewController = ProfileViewController(viewModel: viewModel)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func ok() {
        print("nova mesa")
    }
}
