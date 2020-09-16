//
//  MapViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 15.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewModel {
    var storage: MainStorage?
    var restaurants: [Restaurant] = []
    var storageType: StorageType
    
    var restourantsCount: Int {
        return restaurants.count
    }
    
    init (storageType: StorageType) {
        self.storageType = storageType
    }
}

extension MapViewModel {
    func loadRestaurants(callback: @escaping () -> Void) {
        storage?.loadRestaurants(storageType: storageType, callback: { [weak self] data in
            guard let self = self else { return }
            self.restaurants = data
            callback()
        })
    }
    
    func annotations(callback: @escaping ([MKAnnotation]) -> Void) {
        var result: [MKAnnotation] = []
        
        for restaurant in restaurants {
        }
    }
}
