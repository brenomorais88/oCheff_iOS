//
//  EstablishmentsViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 19/02/23.
//

import Foundation
import Alamofire

class EstablishmentsViewModel: ViewModel {
    let delegate: HomeCoordinatorProtocol
    let service: EstablishmentService
    
    init(delegate: HomeCoordinatorProtocol,
         service: EstablishmentService) {
        self.delegate = delegate
        self.service = service
        
        super.init()
    }
    
    func showEstablishment() {
        self.delegate.showEstablishment()
    }
    
    func getEstablishmentCategory(callback: (Bool, [EstablishmentCategoryResponse]?) -> ()) {
        self.service.getEstablishmentCategory(callback: callback)
    }
    
    func getNearEstablishments(callback: @escaping (Bool, [EstablishmentResponse]?) -> ()) {
        let params = EstablishmentRequest()
        self.service.getNearEstablishments(params: params, callback: callback)
    }
}

    
