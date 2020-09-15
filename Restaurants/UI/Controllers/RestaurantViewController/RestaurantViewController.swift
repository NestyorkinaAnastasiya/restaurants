//
//  RestaurantViewController.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 11.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class RestaurantViewController: UIViewController, Storyboarded {
    weak var coordinator: ChildCoordinator?
    var restaurantViewModel: RestaurantViewModel?
    
    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPhoto.image = restaurantViewModel?.loadMainPhoto()
        rating.text = restaurantViewModel?.rating()
    }
}
