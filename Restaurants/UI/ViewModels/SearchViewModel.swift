//
//  StorageViewModel.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

class SearchViewModel {
    let storage: MainStorage
    var restaurants: [Restaurant] = []
    
    init (mainStorage: StorageType) {
        self.storage = MainStorage(mainStorage: mainStorage)
    }
}

extension SearchViewModel {
    func loadRestaurants(callback: @escaping () -> Void) {
        storage.loadRestaurants(callback: { [weak self] data in
            guard let self = self else { return }
            self.restaurants = data
            callback()
        })
    }
    
}
