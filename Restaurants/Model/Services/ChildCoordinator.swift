//
//  ChildCoordinator.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class ChildCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RestaurantViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func restaurant(viewModel: SearchViewModel, row: Int) {
        let vc = RestaurantViewController.instantiate()
        vc.coordinator = self
        vc.restaurantViewModel = RestaurantViewModel(restaurant: viewModel.restaurants[row],
                                                     mainStorage: viewModel.storage.mainStorage)
        navigationController.pushViewController(vc, animated: false)
    }
}
