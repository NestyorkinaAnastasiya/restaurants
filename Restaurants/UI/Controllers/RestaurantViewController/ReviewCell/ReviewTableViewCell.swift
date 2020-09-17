//
//  ReviewTableViewCell.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 17.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class ReviewTableViewCell: UITableViewCell {
    static let cellReuseID = "ReviewTableViewCell"
    
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var review: UILabel!
    
    func setupCell(viewModel: ReviewCellModelView) {
        self.author.text = viewModel.author
        self.date.text = viewModel.date
        self.review.text = viewModel.review
    }
}
