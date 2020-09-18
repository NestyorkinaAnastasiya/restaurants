//
//  Review.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 10.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

struct RemoteReview: Codable {
    let author: String
    let date: String
    let restaurantId: Int
    let reviewText: String
}

struct Review: Codable {
    let author: String
    let date: Date
    let restaurantId: Int
    let reviewText: String
}
