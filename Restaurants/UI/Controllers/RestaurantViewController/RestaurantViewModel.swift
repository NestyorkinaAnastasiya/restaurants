//
//  RestaurantViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class RestaurantViewModel {
    private let storage: MainStorage
    private let restaurant: Restaurant
    private var reviews: [Review] = []
    
    init (restaurant: Restaurant, mainStorage: StorageType) {
        storage = MainStorage(mainStorage: mainStorage)
        self.restaurant = restaurant
    }
}

extension RestaurantViewModel {
    func loadMainPhoto() -> UIImage? {
        guard let url = URL(string: restaurant.imagePaths[0]), let data = try? Data(contentsOf: url) else { return UIImage() }
        return UIImage(data: data)
    }
    
    func rating() -> String {
        return String(restaurant.rating)
    }
}

extension RestaurantViewModel {
    private func reloadReviews (callback: @escaping () -> Void) {
        storage.loadRestaurantReviews(restaurantId: restaurant.id, callback: { [weak self] data in
            guard let self = self else { return }
            self.reviews = data
            callback()
        })
    }
    
    func addReview(author: String, reviewText: String, callback: @escaping () -> Void) {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let date: String = dateFormatter.string(from: currentDate)
        storage.updateReviews(review: Review(restaurantId: restaurant.id,
                                             author: author,
                                             reviewText: reviewText,
                                             date: date)) { [weak self] in
            guard let self = self else { return }
            self.reloadReviews(callback: callback)
        }
    }
    
}
