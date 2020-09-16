//
//  MapViewController.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 11.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, Storyboarded {
    weak var coordinator: ChildCoordinator?
    let viewModel = MapViewModel(storageType: .firebase)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MapViewController: MKMapViewDelegate {
    //Tells the delegate that the user tapped one of the annotation view’s accessory buttons.
    func mapView(_: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped: UIControl) {
        
    }
}
