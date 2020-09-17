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
        let storyboard = UIStoryboard(name: "MainTabBarController", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
            as? UITabBarController else { return }
        navigationController.pushViewController(vc, animated: true)
        
        let storage = MainStorage()
        
        // Add childCoordinators
        if let controllers = vc.viewControllers {
            var first = true
            for controller in controllers {
                guard let navController = controller as? UINavigationController,
                    let  viewController = navController.viewControllers.last else { return }
                
                let childCoordinator = ChildCoordinator(navigationController: navController,
                                                        storage: storage)
                childCoordinators.append(childCoordinator)
                
                if let search = viewController as? SearchViewController {
                    search.coordinator = childCoordinator
                    
                    if first == true {
                        search.viewModel = SearchViewModel(storageType: .firebase,
                                                           storage: storage)
                        search.title = "Search"
                        first = false
                    } else {
                        search.viewModel = SearchViewModel(storageType: .coreData,
                                                           storage: storage)
                        search.tabBarItem = UITabBarItem(title: "Favourite",
                                                         image: UIImage(systemName: "star.fill",
                                                                        withConfiguration: nil),
                                                         selectedImage: nil)
                        search.title = "Favourite"
                    }
                    
                } else if let map = viewController as? MapViewController {
                    map.coordinator = childCoordinator
                    map.viewModel = MapViewModel(storageType: .firebase,
                                                 storage: storage)
                    map.title = "Map"
                }
            }
        }
    }
    
}
