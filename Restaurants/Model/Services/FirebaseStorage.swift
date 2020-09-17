//
//  FirebaseStorage.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 10.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

class FirebaseStorage: StorageManager {
    private let restaurantsLink = "https://restaurants-f64d7.firebaseio.com/"
    
    func updateReviews(review: RemoteReview, callback: @escaping () -> Void) {
        guard let url = URL(string: restaurantsLink + "reviews.json") else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                request.httpBody =  try JSONSerialization.data(withJSONObject: review, options: [])
            } catch let error {
                return
            }
                
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard let data = data else { return }//error handling
                do {
                    let _ = try JSONDecoder().decode([String: String].self, from: data)
                    callback()
                } catch let error {
                    //error handling
                }
            })
            task.resume()
    }
    
    func loadRestaurants(callback: @escaping ([Restaurant]) -> Void) {
        guard let url = URL(string: restaurantsLink + "restaurants.json") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
        guard let data = data else { return }//error handling
        do {
            let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
            callback(restaurants)
        } catch let error {
                //error handling
        }
        })
            
            task.resume()
    }
    
    func loadAllReviews(callback: @escaping ([Review]) -> Void) {
        guard let url = URL(string: restaurantsLink + "reviews.json") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }//error handling
            do {
                let result = try JSONDecoder().decode([Int: RemoteReview].self, from: data)
                var reviews: [Review] = []
                let dateFormatter = ISO8601DateFormatter()
                for remoteReview in result {
                    let review = remoteReview.value
                    if let date = dateFormatter.date(from: review.date) {
                        reviews.append(Review(author: review.author,
                                              date: date,
                                              restaurantId: review.restaurantId,
                                              reviewText: review.reviewText))
                    }
                }
                callback(reviews)
            } catch let error {
                //error handling
            }
        })
            
        task.resume()
    }
    
    func loadRestaurantReviews(restaurantId: Int, callback: @escaping ([Review]) -> Void) {
        //  https://restaurants-f64d7.firebaseio.com/reviews.json?orderBy=%22restaurantId%22&equalTo=5
        guard let url = URL(string: restaurantsLink + "reviews.json?orderBy=%22restaurantId%22&equalTo=\(restaurantId)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }//error handling
            do {
                let result = try JSONDecoder().decode([String: RemoteReview].self, from: data)
                var reviews: [Review] = []
                let dateFormatter = ISO8601DateFormatter()
                for remoteReview in result {
                    let review = remoteReview.value
                    if let date = dateFormatter.date(from: review.date) {
                        reviews.append(Review(author: review.author,
                                              date: date,
                                              restaurantId: review.restaurantId,
                                              reviewText: review.reviewText))
                    }
                }
                callback(reviews)
            } catch let error {
                //error handling
                print(error.localizedDescription)
            }
        })
            
        task.resume()
    }
    
}
