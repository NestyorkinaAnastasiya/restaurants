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
    var viewModel: SearchViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchRestaurantBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: RestaurantViewCell.cellReuseID, bundle: nil),
                           forCellReuseIdentifier: RestaurantViewCell.cellReuseID)
        searchRestaurantBar.delegate = self
        
        viewModel.loadRestaurants { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                switch error {
                case .noInternet: return
                case .unavailableServer: return
                default: return
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restourantsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RestaurantViewCell = tableView
            .dequeueReusableCell(withIdentifier: RestaurantViewCell.cellReuseID,
                                 for: indexPath) as? RestaurantViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.restaurantCellViewModel(row: indexPath.row)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.restaurant(viewModel: viewModel, row: indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchRestaurants(text: searchText) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchRestaurantBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRestaurantBar.endEditing(true)
    }
}
