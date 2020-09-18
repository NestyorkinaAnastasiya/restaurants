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
    var viewModel: MapViewModel!
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.annotations { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let annotations):
                self.mapView.addAnnotations(annotations)
            case .failure(let error):
                switch error {
                case .noInternet: return
                case .unavailableServer: return
                default: return
                }
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        coordinator?.restaurant(viewModel: viewModel, annotationView: view)
    }
    
}
