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

class MainStorage {
    private let localStorage = CoreDataStorage()
    private let firebaseStorage = FirebaseStorage()
    
    func updateReviews(review: RemoteReview, storageType: StorageType, callback: @escaping (AppError?) -> Void) {
        switch storageType {
            case .firebase: firebaseStorage.updateReviews(review: review, callback: callback)
            case .coreData: localStorage.updateReviews(review: review, callback: callback)
        }
    }
    
    func loadRestaurants(storageType: StorageType, callback: @escaping (Result<[Restaurant], AppError>) -> Void) {
        switch storageType {
            case .firebase: firebaseStorage.loadRestaurants(callback: callback)
            case .coreData: localStorage.loadRestaurants(callback: callback)
        }
    }
    
    func loadAllReviews(storageType: StorageType, callback: @escaping (Result<[Review], AppError>) -> Void) {
        switch storageType {
            case .firebase: firebaseStorage.loadAllReviews(callback: callback)
            case .coreData: localStorage.loadAllReviews(callback: callback)
        }
    }
    
    func loadRestaurantReviews(restaurantId: Int,
                               storageType: StorageType,
                               callback: @escaping (Result<[Review], AppError>) -> Void) {
        switch storageType {
            case .firebase: firebaseStorage.loadRestaurantReviews(restaurantId: restaurantId, callback: callback)
            case .coreData: localStorage.loadRestaurantReviews(restaurantId: restaurantId, callback: callback)
        }
    }
    
}
