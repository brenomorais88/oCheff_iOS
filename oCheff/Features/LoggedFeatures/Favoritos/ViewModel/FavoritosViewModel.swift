//
//  FavoritosViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 20/02/23.
//

import Foundation

class FavoritosViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    let service: EstablishmentService
    
    init(delegate: HomeCoordinatorProtocol,
         service: EstablishmentService) {
        self.delegate = delegate
        self.service = service
        super.init()
    }
    
    func showEstablishment(id: Int) {
        self.delegate.showEstablishment(id: id)
    }
    
    func getFavoritesEstablishments(callback: (Bool, [EstablishmentResponse]?) -> ()) {
        self.service.getFavoritesEstablishments(callback: callback)
    }
}
