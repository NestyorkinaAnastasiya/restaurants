//
//  RestaurantViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class RestaurantViewModel {
    private var storage: MainStorage?
    private let restaurant: Restaurant
    private var reviews: [Review] = []
    private var storageType: StorageType
    
    var photoesCount: Int {
        return restaurant.imagePaths.count
    }
    
    init (restaurant: Restaurant, storageType: StorageType) {
        self.storageType = storageType
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
    
    func annotation() -> MKAnnotation {
        let annotation = MKPointAnnotation()
        
        annotation.title = restaurant.name
        
        let latitude = restaurant.location["lat"]!
        let longitude = restaurant.location["lon"]!
        let centerCoordinate = CLLocationCoordinate2D(latitude: Double(latitude),
                                                      longitude: Double(longitude))
        annotation.coordinate = centerCoordinate
        
        return annotation
    }
    
    func imageLink(row: Int) -> String {
        return restaurant.imagePaths[row]
    }
}

extension RestaurantViewModel {
    private func reloadReviews (callback: @escaping () -> Void) {
        storage?.loadRestaurantReviews(restaurantId: restaurant.id,
                                      storageType: storageType,
                                      callback: { [weak self] data in
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
        storage?.updateReviews(review: Review(restaurantId: restaurant.id,
                                             author: author,
                                             reviewText: reviewText,
                                             date: date),
                              storageType: storageType) { [weak self] in
            guard let self = self else { return }
            self.reloadReviews(callback: callback)
        }
    }
    
}
