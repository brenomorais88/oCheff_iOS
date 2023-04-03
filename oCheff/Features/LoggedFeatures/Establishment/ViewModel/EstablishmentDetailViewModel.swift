//
//  EstablishmentDetailViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 20/02/23.
//

import Foundation

class EstablishmentDetailViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    let service: EstablishmentService
    let id: Int
    
    init(id: Int,
         delegate: HomeCoordinatorProtocol,
         service: EstablishmentService = EstablishmentService()) {
        self.id = id
        self.delegate = delegate
        self.service = service
        super.init()
    }
    
    func openMenu() {
        self.delegate.openMenu()
    }
    
    func getEstablishmentsDetail(callback: @escaping (Bool, EstablishmentResponse?) -> ()) {
        self.service.getEstablishmentsDetail(id: id, callback: callback)
    }
}
