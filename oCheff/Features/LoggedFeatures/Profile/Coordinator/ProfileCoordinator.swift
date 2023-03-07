//
//  ProfileCoordinator.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 18/02/23.
//

import Foundation

protocol ProfileCoordinatorProtocol {
    func ok()
}

class ProfileCoordinator: Coordinator {
    
    override func didInit() {
        let viewModel = ProfileViewModel(delegate: self)
        self.viewController = ProfileViewController(viewModel: viewModel)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func ok() {
        print("nova mesa")
    }
}
