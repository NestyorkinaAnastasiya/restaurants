//
//  RestaurantViewController.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 11.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class RestaurantViewController: UIViewController, Storyboarded {
    weak var coordinator: ChildCoordinator?
    var viewModel: RestaurantViewModel!
    
    @IBOutlet private weak var mainPhoto: UIImageView!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPhoto.image = viewModel.loadMainPhoto()
        rating.text = viewModel.rating()
        let annotation = viewModel.annotation()
        mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate,
                                                  latitudinalMeters: 800,
                                                  longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let imageCellNib = UINib(nibName: PhotoCollectionViewCell.cellReuseID,
                                 bundle: nil)
        collectionView.register(imageCellNib,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.cellReuseID)
    }
}

extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellReuseID,
                                 for: indexPath) as? PhotoCollectionViewCell else {
                       return UICollectionViewCell()
        }
        cell.setupImage(imageLink: viewModel.imageLink(row: indexPath.row))
        return cell
    }
    
    
}
