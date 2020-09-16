//
//  PhotoCollectionViewCell.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 16.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let cellReuseID = "PhotoCollectionViewCell"
    @IBOutlet private weak var imageView: UIImageView!
    private var link: String = ""
    
    func setupImage(imageLink: String) {
        link = imageLink
        DispatchQueue.global().async {
            if let url = URL(string: self.link) {
                if let data = try? Data(contentsOf: url) {
                    if self.link == imageLink {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }        
    }
}
