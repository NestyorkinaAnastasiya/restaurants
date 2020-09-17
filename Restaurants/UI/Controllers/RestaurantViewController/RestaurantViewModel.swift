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
    private var storage: MainStorage
    private let restaurant: Restaurant
    private var reviews: [Review] = []
    private var storageType: StorageType
    
    var photoesCount: Int {
        return restaurant.imagePaths.count
    }
    var info: String {
        return "\(restaurant.description)"
    }
    var address: String {
        return "\(restaurant.address)"
    }
    var name: String {
        return restaurant.name
    }
    var reviewCount: Int {
        reviews.count
    }
    
    init (restaurant: Restaurant, storageType: StorageType, storage: MainStorage) {
        self.storage = storage
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
    
    func reviewCellModel(row: Int) -> ReviewCellModelView {
        let review = reviews[row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        
        let date = dateFormatter.string(from: review.date)
        
        return ReviewCellModelView(author: review.author,
                                   date: date,
                                   review: review.reviewText)
    }
}

extension RestaurantViewModel {
    func reloadReviews (callback: @escaping () -> Void) {
        storage.loadRestaurantReviews(restaurantId: restaurant.id,
                                      storageType: storageType,
                                      callback: { [weak self] data in
            guard let self = self else { return }
            self.reviews = data.sorted{ $0.date < $1.date }
            callback()
        })
    }
    
    func addReview(author: String, reviewText: String, callback: @escaping () -> Void) {
        let currentDate = Date()
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.string(from: currentDate)
        storage.updateReviews(review: RemoteReview(author: author,
                                                   date: date,
                                                   restaurantId: restaurant.id,
                                                   reviewText: reviewText),
                              storageType: storageType) { [weak self] in
            guard let self = self else { return }
            self.reloadReviews(callback: callback)
        }
    }
    
}
