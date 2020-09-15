//
//  SearchViewController.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 11.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, Storyboarded {
    weak var coordinator: ChildCoordinator?    
    var searchViewModel: SearchViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchRestaurantBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: RestaurantViewCell.cellReuseID, bundle: nil), forCellReuseIdentifier: RestaurantViewCell.cellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        searchRestaurantBar.delegate = self
        
        searchViewModel?.loadRestaurants { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let restaurants = searchViewModel?.restaurants else { return 0 }
        return restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RestaurantViewCell = tableView
            .dequeueReusableCell(withIdentifier: RestaurantViewCell.cellReuseID,
                                 for: indexPath) as? RestaurantViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = searchViewModel.restaurantCellViewModel(row: indexPath.row)
        return cell
      }
}

extension SearchViewController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = searchViewModel else { return }
        coordinator?.restaurant(viewModel: viewModel, row: indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel?.searchRestaurants(text: searchText) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
