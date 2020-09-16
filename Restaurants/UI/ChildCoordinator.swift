//
//  ChildCoordinator.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit
import MapKit

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
    
    func restaurant(viewModel: TabViewModel, row: Int) {
        let vc = RestaurantViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = RestaurantViewModel(restaurant: viewModel.restaurants[row],
                                                     storageType: viewModel.storageType)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func restaurant(viewModel: TabViewModel, annotationView: MKAnnotationView) {
        guard let annotation = annotationView.annotation as? RestaurantAnnotationModelView else { return }
        let vc = RestaurantViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = RestaurantViewModel(restaurant: annotation.restaurant,
                                           storageType: viewModel.storageType)
        navigationController.pushViewController(vc, animated: false)
    }
}
