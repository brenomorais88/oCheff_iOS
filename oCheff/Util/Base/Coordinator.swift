//
//  Coordinator.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation
import UIKit


protocol CoordinatorProtocol {
    func didInit()
    func start()
    func initialViewController() -> UIViewController?
}

class Coordinator: CoordinatorProtocol {
    let navigationController: UINavigationController
    var viewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.didInit()
    }
    
    func didInit() {
        // need be override
    }
    
    func start() {
        guard let vc = self.viewController else { return }
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func initialViewController() -> UIViewController? {
        return self.viewController
    }
}
