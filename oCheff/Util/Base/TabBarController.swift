//
//  TabBarController.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 18/02/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    private var homeCoordinator: HomeCoordinator?
    private var historicCoordinator: HistoricCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    
    private let homeNav = NavigationController()
    private let historicNav = NavigationController()
    private let profileNav = NavigationController()
    
    func setupTabBar() {
        self.tabBarController?.tabBar.isTranslucent = false
        
        let firstVC = getFirstViewController()
        let secondVC = getSecondController()
        let thirdVC = getThirdController()
        
        self.viewControllers = [firstVC, secondVC, thirdVC]
        
        let item1 = UITabBarItem(title: "Início",
                                 image: UIImage(named: "icon_home"),
                                 tag: 0)
        
        let item2 = UITabBarItem(title: "Histórico",
                                 image: UIImage(named: "icon_historic"),
                                 tag: 1)
        
        let item3 = UITabBarItem(title: "Perfil",
                                 image: UIImage(named: "icon_name"),
                                 tag: 2)

        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        thirdVC.tabBarItem = item3
                
        UITabBar.appearance().tintColor = UIColor.primaryColor
    }
    
    func getFirstViewController() -> UIViewController {
        homeCoordinator = HomeCoordinator(navigationController: homeNav)
        homeCoordinator?.start()
        if let nav = homeCoordinator?.navigationController {
            return nav
            
        } else {
            return UIViewController()
        }
    }
    
    func getSecondController() -> UIViewController {
        historicCoordinator = HistoricCoordinator(navigationController: historicNav)
        historicCoordinator?.start()
        if let nav = historicCoordinator?.navigationController {
            return nav
            
        } else {
            return UIViewController()
        }
    }
    
    func getThirdController() -> UIViewController {
        profileCoordinator = ProfileCoordinator(navigationController: profileNav)
        profileCoordinator?.start()
        if let nav = profileCoordinator?.navigationController {
            return nav
            
        } else {
            return UIViewController()
        }
    }
}
