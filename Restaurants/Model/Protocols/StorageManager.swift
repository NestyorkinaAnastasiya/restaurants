//
//  File.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 10.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

protocol StorageManager {
    func updateReviews(review: RemoteReview, callback: @escaping (AppError?) -> Void)
    func loadRestaurants(callback: @escaping (Result<[Restaurant], AppError>) -> Void)
    func loadAllReviews(callback: @escaping (Result<[Review], AppError>) -> Void)
    func loadRestaurantReviews(restaurantId: Int, callback: @escaping (Result<[Review], AppError>) -> Void)
}
