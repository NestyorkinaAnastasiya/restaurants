//
//  MapViewController.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 11.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class MapViewController: UIViewController, Storyboarded {
    weak var coordinator: ChildCoordinator?
    private let searchViewModel = SearchViewModel(mainStorage: .firebase)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
