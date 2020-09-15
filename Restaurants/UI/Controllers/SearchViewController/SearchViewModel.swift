//
//  StorageViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel {
    let storage: MainStorage
    var restaurants: [Restaurant] = []
    private var allRestaurants: [Restaurant] = []
    
    init (mainStorage: StorageType) {
        self.storage = MainStorage(mainStorage: mainStorage)
    }
}

extension SearchViewModel {
    func loadRestaurants(callback: @escaping () -> Void) {
        storage.loadRestaurants(callback: { [weak self] data in
            guard let self = self else { return }
            self.restaurants = data
            self.allRestaurants = data
            callback()
        })
    }
    
    func searchRestaurants(text: String, callback: @escaping () -> Void) {
        DispatchQueue.global().async {
            if text == "" {
                self.restaurants = self.allRestaurants
            } else {
                self.restaurants = []
                for restaurant in self.allRestaurants {
                    if restaurant.name.contains(text) {
                        self.restaurants.append(restaurant)
                    }
                }
            }
            callback()
        }
    }
    
    func restaurantCellViewModel(row: Int) -> RestaurantCellViewModel {
        return RestaurantCellViewModel(restaurant: restaurants[row])
    }
}
