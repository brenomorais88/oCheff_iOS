//
//  HomeCoordinator.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation

protocol HomeCoordinatorProtocol {
    func openNewTable()
    func showEstablishments()
    func showFavorites()
    func showEstablishment(id: Int)
    func openMenu()
    func openOrders()
    func closeAccount() 
}

class HomeCoordinator: Coordinator {
    
    override func didInit() {
        let viewModel = HomeViewModel(delegate: self)
        self.viewController = HomeViewController(viewModel: viewModel)
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func showEstablishment(id: Int) {
        let viewModel = EstablishmentDetailViewModel(id: id, delegate: self)
        let vc = EstablishmentDetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func openNewTable() {
        let viewModel = NewTableViewModel(delegate: self)
        let vc = NewTableViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showEstablishments() {
        let service = EstablishmentService()
        let viewModel = EstablishmentsViewModel(delegate: self,
                                                service: service)
        let vc = EstablishmentsViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func showFavorites() {
        let service = EstablishmentService()
        let viewModel = FavoritosViewModel(delegate: self, service: service)
        let vc = FavoritosViewController(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func openMenu() {
        let viewModel = MenuViewModel(delegate: self)
        let vc = MenuViewController(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func openOrders() {
        let viewModel = OrderViewModel()
        let vc = OrderViewController(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func closeAccount() {
        let viewModel = CloseAccountViewModel(delegate: self)
        let vc = CloseAccountViewController(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
