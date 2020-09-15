//
//  RestaurantViewCell.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 14.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class RestaurantViewCell: UITableViewCell {
    static let cellReuseID = "RestaurantViewCell"
    var viewModel: RestaurantCellViewModel! {
        didSet {
            setupCell()
        }
    }
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    
    func setupCell() {        
        self.name.text = viewModel.name
        self.info.text = viewModel.description
        
        viewModel.mainImage() { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.picture.image = image
            }
        }
       
    }
}
