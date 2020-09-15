//
//  Review.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 10.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

struct Review: Codable {
    let restaurantId: Int
    let author: String
    let reviewText: String
    let date: String
}
