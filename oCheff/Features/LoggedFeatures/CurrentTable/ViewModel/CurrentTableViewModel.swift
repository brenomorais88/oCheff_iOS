//
//  CurrentTableViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 24/02/23.
//

import Foundation

class CurrentTableViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol

    init(delegate: HomeCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    func sendOrder() {
        self.delegate.openOrders()
    }
    
    func openMenu() {
        self.delegate.openMenu()
    }
    
    func callWaiter() {
        print("chamar garçom")
    }
    
    func closeAccount() {
        self.delegate.closeAccount()
    }
}

