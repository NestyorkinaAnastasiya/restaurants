//
//  Restaurant.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 10.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    let id: Int
    let name: String
    let description: String
    let address: String
    let location: [String: Float]
    let imagePaths: [String]
    let rating: Float
}

struct RestaurantFullInfo {
    let restaurant: Restaurant
    var reviews: [Review]
}
