//
//  MainStorage.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

enum StorageType {
    case firebase
    case coreData
}

class MainStorage: StorageManager {
    private let localStorage = CoreDataStorage()
    private let firebaseStorage = FirebaseStorage()
    let mainStorage: StorageType
    
    init (mainStorage: StorageType) {
        self.mainStorage = mainStorage
    }
    
    func updateReviews(review: Review, callback: @escaping () -> Void) {
        switch mainStorage {
            case .firebase: firebaseStorage.updateReviews(review: review, callback: callback)
            case .coreData: localStorage.updateReviews(review: review, callback: callback)
        }
    }
    
    func loadRestaurants(callback: @escaping ([Restaurant]) -> Void) {
        switch mainStorage {
            case .firebase: firebaseStorage.loadRestaurants(callback: callback)
            case .coreData: localStorage.loadRestaurants(callback: callback)
        }
    }
    
    func loadAllReviews(callback: @escaping ([Int : Review]) -> Void) {
        switch mainStorage {
            case .firebase: firebaseStorage.loadAllReviews(callback: callback)
            case .coreData: localStorage.loadAllReviews(callback: callback)
        }
    }
    
    func loadRestaurantReviews(restaurantId: Int, callback: @escaping ([Review]) -> Void) {
        switch mainStorage {
            case .firebase: firebaseStorage.loadRestaurantReviews(restaurantId: restaurantId, callback: callback)
            case .coreData: localStorage.loadRestaurantReviews(restaurantId: restaurantId, callback: callback)
        }
    }
    
}
