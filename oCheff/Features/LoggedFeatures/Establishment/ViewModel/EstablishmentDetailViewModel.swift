//
//  EstablishmentDetailViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 20/02/23.
//

import Foundation

class EstablishmentDetailViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    
    init(delegate: HomeCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    func openMenu() {
        self.delegate.openMenu()
    }
}
