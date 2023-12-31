//
//  HomeViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation

class HomeViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    
    init(delegate: HomeCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    func openNewTable() {
        self.delegate.openNewTable()
    }
    
    func showEstablishments() {
        self.delegate.showEstablishments()
    }
    
    func showFavorites() {
        self.delegate.showFavorites()
    }
}
