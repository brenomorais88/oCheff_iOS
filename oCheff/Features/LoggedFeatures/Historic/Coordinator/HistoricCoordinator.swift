//
//  HistoricCoordinator.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation
import UIKit

protocol HistoricCoordinatorProtocol {
    func showHistoricDetail()
}

class HistoricCoordinator: Coordinator {
    override func didInit() {
        let viewModel = HistoricViewModel(delegate: self)
        self.viewController = HistoricViewController(viewModel: viewModel)
    }
}

extension HistoricCoordinator: HistoricCoordinatorProtocol {
    func showHistoricDetail() {
        let viewModel = HistoricDetailViewModel(delegate: self)
        let vc = HistoricDetailViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
}
