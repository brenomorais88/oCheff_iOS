//
//  MenuViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 24/02/23.
//

import Foundation

class MenuViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    
    init(delegate: HomeCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    func showEstablishment() {
        self.delegate.showEstablishment()
    }
    
    func showOrders() {
        self.delegate.openOrders()
    }
}
