//
//  HistoricViewModel.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation

class HistoricViewModel: ViewModel {
    let delegate: HistoricCoordinatorProtocol
    
    init(delegate: HistoricCoordinatorProtocol) {
        self.delegate = delegate
        super.init()
    }
    
    func showHistoricDetail() {
        self.delegate.showHistoricDetail()
    }
}
