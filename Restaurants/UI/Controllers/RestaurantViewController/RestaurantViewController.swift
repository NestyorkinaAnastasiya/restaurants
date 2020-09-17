//
//  RestaurantViewController.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 11.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class RestaurantViewController: UIViewController, Storyboarded {
    weak var coordinator: ChildCoordinator?
    var viewModel: RestaurantViewModel!

    private let itemsPerRow: CGFloat = 2
    private let minimumItemSpacing: CGFloat = 8
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    @IBOutlet private weak var mainPhoto: UIImageView!
    @IBOutlet private weak var rating: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var info: UILabel!
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var reviewTextView: UITextView!
    @IBOutlet private weak var authorTextField: UITextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPhoto.image = viewModel.loadMainPhoto()
        rating.text = viewModel.rating()
        info.text = viewModel.info
        address.text = viewModel.address
        title = viewModel.name
        
        let annotation = viewModel.annotation()
        mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate,
                                                  latitudinalMeters: 800,
                                                  longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let imageCellNib = UINib(nibName: PhotoCollectionViewCell.cellReuseID,
                                 bundle: nil)
        collectionView.register(imageCellNib,
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.cellReuseID)
        
        tableView.register(UINib(nibName: ReviewTableViewCell.cellReuseID, bundle: nil),
        forCellReuseIdentifier: ReviewTableViewCell.cellReuseID)
        
        viewModel.reloadReviews { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }
    
    @IBAction func tapSendButton(_ sender: Any) {
        guard let authorText = authorTextField.text, let reviewText = reviewTextView.text else { return }
        viewModel.addReview(author: authorText,
                            reviewText: reviewText) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: CollectionViewDelegate
extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellReuseID,
                                 for: indexPath) as? PhotoCollectionViewCell else {
                       return UICollectionViewCell()
        }
        cell.setupImage(imageLink: viewModel.imageLink(row: indexPath.row))
        return cell
    }
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace =
            sectionInsets.left + sectionInsets.right + minimumItemSpacing * (itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
}

// MARK: TableViewDelegate
extension RestaurantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviewCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ReviewTableViewCell = tableView
            .dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellReuseID,
                                    for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
           
        cell.setupCell(viewModel: viewModel.reviewCellModel(row: indexPath.row))
        return cell
    }
}

// MARK: keyboard functions
extension RestaurantViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let kbRect = view.convert(keyboardFrame.cgRectValue, from: nil)
            let hiddenScrollViewRect = scrollView.frame.intersection(kbRect)
            let contentInsets = UIEdgeInsets(
                top: 0, left: 0, bottom: hiddenScrollViewRect.size.height + 5, right: 0
            )
            
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect = view.frame
            aRect.size.height -= keyboardFrame.cgRectValue.height
            let LeftDownRect = CGRect(x: authorTextField.frame.origin.x,
                                      y: authorTextField.frame.origin.y + authorTextField.frame.height,
                                      width: authorTextField.frame.width,
                                      height: authorTextField.frame.height)
            
            if !aRect.contains(LeftDownRect.origin) {
                scrollView.scrollRectToVisible(authorTextField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }    
}

extension RestaurantViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
