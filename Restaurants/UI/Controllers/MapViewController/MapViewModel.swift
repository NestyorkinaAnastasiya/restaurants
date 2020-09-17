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

class MapViewModel: TabViewModel {
    private var storage: MainStorage
    var restaurants: [Restaurant] = []
    var storageType: StorageType
    
    var restourantsCount: Int {
        return restaurants.count
    }
    
    init (storageType: StorageType,
          storage: MainStorage) {
        self.storageType = storageType
        self.storage = storage
    }
}

extension MapViewModel {
    
    func annotations(callback: @escaping ([MKAnnotation]) -> Void) {
        storage.loadRestaurants(storageType: storageType, callback: { [weak self] data in
            guard let self = self else { return }
            self.restaurants = data
               
            var result: [MKAnnotation] = []
            for restaurant in self.restaurants {
                let annotation = RestaurantAnnotationModelView(restaurant: restaurant)
                result.append(annotation)
            }
            
            callback(result)
        })
    }
}
