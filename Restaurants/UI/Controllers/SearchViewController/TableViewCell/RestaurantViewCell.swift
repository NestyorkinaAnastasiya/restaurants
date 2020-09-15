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
    
   
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    
    func setupCell(imageLink: String, name: String, description: String) {
        guard let url = URL(string: imageLink), let data = try? Data(contentsOf: url) else { return }
        picture.image = UIImage(data: data)
        self.name.text = name
        self.info.text = description
    }
}
