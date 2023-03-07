//
//  HistoricDetailViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import Foundation

class HistoricDetailViewModel: ViewModel {
    let delegate: HistoricCoordinatorProtocol
    
    init(delegate: HistoricCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
}
