//
//  File.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 10.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

protocol StorageManager {
    func updateReviews(review: RemoteReview, callback: @escaping () -> Void)
    func loadRestaurants(callback: @escaping ([Restaurant]) -> Void)
    func loadAllReviews(callback: @escaping ([Review]) -> Void)
    func loadRestaurantReviews(restaurantId: Int, callback: @escaping ([Review]) -> Void)
}
