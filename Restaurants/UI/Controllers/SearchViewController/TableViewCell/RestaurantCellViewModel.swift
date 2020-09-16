//
//  RestaurantCellViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 15.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class RestaurantCellViewModel {
    private let restaurant: Restaurant
    var name: String {
        return restaurant.name
    }
    var description: String {
        return restaurant.description
    }
    var imageLink: String {
        return restaurant.imagePaths[0]
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
 
}

extension RestaurantCellViewModel {
     func image(imagePath: Int, callback: @escaping (String, UIImage?) -> Void) {
         DispatchQueue.global().async {
            let link = self.restaurant.imagePaths[imagePath]
             if let url = URL(string: link) {
                 if let data = try? Data(contentsOf: url) {
                     callback(link, UIImage(data: data))
                 }
             }
         }
     }
     
     func mainImage(callback: @escaping (String, UIImage?) -> Void) {
         image(imagePath: 0, callback: callback)
     }
    
}
