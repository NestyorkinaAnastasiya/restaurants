//
//  MainCoordinator.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 11.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MainTabBarController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
        // Add childCoordinators
        if let controllers = vc.viewControllers {
            for controller in controllers {
                guard let navController = controller as? UINavigationController,
                    let  viewController = navController.viewControllers.last else { return }
                
                let childCoordinator = ChildCoordinator(navigationController: navController)
                childCoordinators.append(childCoordinator)
                
                if let search = viewController as? SearchViewController {
                    search.coordinator = childCoordinator
                    search.searchViewModel = SearchViewModel(mainStorage: .firebase)
                } else if let map = viewController as? MapViewController {
                    map.coordinator = childCoordinator
                }
            }
        }
    }
}
