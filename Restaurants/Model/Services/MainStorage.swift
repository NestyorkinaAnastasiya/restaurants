//
//  MainStorage.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

enum StorageType {
    case local
    case remote
}

class MainStorage {
    private let localStorage = CoreDataStorage()
    private let firebaseStorage = FirebaseStorage()
    
    func updateReviews(review: RemoteReview, storageType: StorageType, callback: @escaping (AppError?) -> Void) {
        switch storageType {
            case .remote: firebaseStorage.updateReviews(review: review, callback: callback)
            case .local: localStorage.updateReviews(review: review, callback: callback)
        }
    }
    
    func loadRestaurants(storageType: StorageType, callback: @escaping (Result<[Restaurant], AppError>) -> Void) {
        switch storageType {
            case .remote: firebaseStorage.loadRestaurants(callback: callback)
            case .local: localStorage.loadRestaurants(callback: callback)
        }
    }
    
    func loadAllReviews(storageType: StorageType, callback: @escaping (Result<[Review], AppError>) -> Void) {
        switch storageType {
            case .remote: firebaseStorage.loadAllReviews(callback: callback)
            case .local: localStorage.loadAllReviews(callback: callback)
        }
    }
    
    func loadRestaurantReviews(restaurantId: Int,
                               storageType: StorageType,
                               callback: @escaping (Result<[Review], AppError>) -> Void) {
        switch storageType {
            case .remote: firebaseStorage.loadRestaurantReviews(restaurantId: restaurantId, callback: callback)
            case .local: localStorage.loadRestaurantReviews(restaurantId: restaurantId, callback: callback)
        }
    }
    
}
