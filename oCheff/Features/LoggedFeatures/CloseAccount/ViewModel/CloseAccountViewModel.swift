//
//  CloseAccountViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 25/02/23.
//

import Foundation

class CloseAccountViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    
    init(delegate: HomeCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
}
