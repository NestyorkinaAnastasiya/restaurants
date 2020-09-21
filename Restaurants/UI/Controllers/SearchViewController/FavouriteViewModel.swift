//
//  FavouriteViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 21.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class FavouriteViewModel: TabSearchViewModel {
    private var storage: MainStorage
    var restaurants: [Restaurant] = []
    private var allRestaurants: [Restaurant] = []
    var storageType: StorageType {
        return .local
    }
    var restourantsCount: Int {
        return restaurants.count
    }
    
    init (storage: MainStorage) {
        self.storage = storage
    }
}

extension FavouriteViewModel {
    func loadRestaurants(callback: @escaping (AppError?) -> Void) {
        storage.loadRestaurants(storageType: .local, callback: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.restaurants = data
                self.allRestaurants = data
                callback(nil)
                
            case .failure(let error):
                callback(error)
            }
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
