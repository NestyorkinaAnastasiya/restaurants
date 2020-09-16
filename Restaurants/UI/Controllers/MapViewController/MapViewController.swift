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
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.annotations { [weak self] annotations in
            guard let self = self else { return }
            self.mapView.addAnnotations(annotations)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        coordinator?.restaurant(viewModel: viewModel, annotationView: view)
    }
    
}
