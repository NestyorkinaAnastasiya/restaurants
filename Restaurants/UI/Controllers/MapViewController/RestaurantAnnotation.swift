//
//  RestaurantAnnotation.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 16.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import MapKit
class RestaurantAnnotationModelView: NSObject, MKAnnotation {
    
    // Center latitude and longitude of the annotation view.
    // The implementation of this property must be KVO compliant.
    var coordinate: CLLocationCoordinate2D

    
    // Title and subtitle for use by selection UI.
    var title: String?

    var subtitle: String?
    
    let restaurant: Restaurant
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        title = restaurant.name
        let latitude = restaurant.location["lat"]!
        let longitude = restaurant.location["lon"]!
        let centerCoordinate = CLLocationCoordinate2D(latitude: Double(latitude),
                                                      longitude: Double(longitude))
        self.coordinate = centerCoordinate
    }
    
}
