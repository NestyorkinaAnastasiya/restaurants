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
    
    func updateReviews(review: Review, callback: @escaping () -> Void) {
        guard let url = URL(string: restaurantsLink + "reviews.json") else {return}
        DispatchQueue.global().async {
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
    }
    
    func loadRestaurants(callback: @escaping ([Restaurant]) -> Void) {
        guard let url = URL(string: restaurantsLink + "restaurants.json") else {return}
        DispatchQueue.global().async {
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
    }
    
    func loadAllReviews(callback: @escaping ([Int : Review]) -> Void) {
        guard let url = URL(string: restaurantsLink + "reviews.json") else {return}
        DispatchQueue.global().async {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard let data = data else { return }//error handling
                do {
                    let reviews = try JSONDecoder().decode([Int: Review].self, from: data)
                    callback(reviews)
                } catch let error {
                    //error handling
                }
            })
            
            task.resume()
        }
    }
    
    func loadRestaurantReviews(restaurantId: Int, callback: @escaping ([Review]) -> Void) {
        //  https://restaurants-f64d7.firebaseio.com/reviews.json?orderBy="restaurantId"&equalTo

        guard let url = URL(string: restaurantsLink + "reviews.json?orderBy=\"\(restaurantId)\"&equalTo") else {return}
        DispatchQueue.global().async {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard let data = data else { return }//error handling
                do {
                    let reviews = try JSONDecoder().decode([Review].self, from: data)
                    callback(reviews)
                } catch let error {
                    //error handling
                }
            })
            
            task.resume()
        }
    }
    
}
