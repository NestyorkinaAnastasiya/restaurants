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
    
    func annotations(callback: @escaping (Result<[MKAnnotation], AppError>) -> Void) {
        storage.loadRestaurants(storageType: storageType, callback: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.restaurants = data
                   
                var result: [MKAnnotation] = []
                for restaurant in self.restaurants {
                    let annotation = RestaurantAnnotationModelView(restaurant: restaurant)
                    result.append(annotation)
                }
                
                callback(.success(result))
                
            case .failure(let error):
                callback(.failure(error))
            }
        })
    }
}
