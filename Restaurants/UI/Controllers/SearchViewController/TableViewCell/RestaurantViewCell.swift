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
        name.text = viewModel.name
        info.text = viewModel.description
        picture.image = nil

        viewModel.mainImage() { [weak self] link, image in
            guard let self = self else { return }
            if link == self.viewModel.imageLink {
                DispatchQueue.main.async {
                    self.picture.image = image
                }
            }
        }
       
    }
}
