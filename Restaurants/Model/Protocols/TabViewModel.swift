//
//  ViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 16.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

protocol TabViewModel {
    var restaurants: [Restaurant] { get set }
    var storageType: StorageType { get set }
}
