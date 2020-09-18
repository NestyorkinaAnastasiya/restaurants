//
//  StorageViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel: TabViewModel {
    private var storage: MainStorage
    var restaurants: [Restaurant] = []
    private var allRestaurants: [Restaurant] = []
    var storageType: StorageType
    
    var restourantsCount: Int {
        return restaurants.count
    }
    
    init (storageType: StorageType, storage: MainStorage) {
        self.storageType = storageType
        self.storage = storage
    }
}

extension SearchViewModel {
    func loadRestaurants(callback: @escaping (AppError?) -> Void) {
        storage.loadRestaurants(storageType: storageType, callback: { [weak self] result in
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
