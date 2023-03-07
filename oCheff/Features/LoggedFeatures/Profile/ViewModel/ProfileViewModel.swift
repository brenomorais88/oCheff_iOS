//
//  ProfileViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation

class ProfileViewModel: ViewModel {
    let delegate: ProfileCoordinatorProtocol
    
    init(delegate: ProfileCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
}
