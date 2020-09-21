//
//  ViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 16.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

protocol TabViewModel {
    var restaurants: [Restaurant] { get set }
    var storageType: StorageType { get }    
    var restourantsCount: Int { get }
}

protocol TabSearchViewModel: TabViewModel {
    func restaurantCellViewModel(row: Int) -> RestaurantCellViewModel
    func loadRestaurants(callback: @escaping (AppError?) -> Void)
    func searchRestaurants(text: String, callback: @escaping () -> Void)
}
