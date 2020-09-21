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
    
    func updateReviews(review: RemoteReview, callback: @escaping (AppError?) -> Void) {
        guard let url = URL(string: restaurantsLink + "reviews.json") else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                request.httpBody =  try JSONEncoder().encode(review)
            } catch let error {
                print(error.localizedDescription)
            }
                
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
                guard let response = response as? HTTPURLResponse else { return }
                if let error = error {
                    if let appError = self.errorHandling(response: response, error: error) {
                        callback(appError)
                    }
                } else {
                    callback(nil)
                }
            })
            task.resume()
    }
    
    func loadRestaurants(callback: @escaping (Result<[Restaurant], AppError>) -> Void) {
        guard let url = URL(string: restaurantsLink + "restaurants.json") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let error = error {
                if let appError = self.errorHandling(response: response, error: error) {
                    callback(.failure(appError))
                }
            } else {
                guard let data = data else { return }
                do {
                    let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
                    callback(.success(restaurants))
                } catch let error {
                    print(error.localizedDescription)
                    
                }
            }
        })
        
        task.resume()
    }
    
    func loadAllReviews(callback: @escaping (Result<[Review], AppError>) -> Void) {
        guard let url = URL(string: restaurantsLink + "reviews.json") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let error = error {
                if let appError = self.errorHandling(response: response, error: error) {
                    callback(.failure(appError))
                }
            } else {
                guard let data = data else { return }
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
                    callback(.success(reviews))
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
            
        task.resume()
    }
    
    func loadRestaurantReviews(restaurantId: Int, callback: @escaping (Result<[Review], AppError>) -> Void) {
        //  https://restaurants-f64d7.firebaseio.com/reviews.json?orderBy=%22restaurantId%22&equalTo=5
        guard let url = URL(string: restaurantsLink + "reviews.json?orderBy=%22restaurantId%22&equalTo=\(restaurantId)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            if let error = error {
                if let appError = self.errorHandling(response: response, error: error) {
                    callback(.failure(appError))
                }
            } else {
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(DecodableDictionaryContainer<String, RemoteReview>.self, from: data).elements
                    var reviews: [Review] = []
                    let dateFormatter = ISO8601DateFormatter()
                    for review in result {
                        if let date = dateFormatter.date(from: review.date) {
                            reviews.append(Review(author: review.author,
                                                  date: date,
                                                  restaurantId: review.restaurantId,
                                                  reviewText: review.reviewText))
                        }
                    }
                    callback(.success(reviews))
                } catch let error {
                    print("Decode error: " + error.localizedDescription)
                }
            }
        })
            
        task.resume()
    }
    
    private func errorHandling(response: HTTPURLResponse, error: Error) -> AppError? {
        var appError: AppError?
        
        switch response.statusCode {
        case 400: print("400 Bad Request: \(error.localizedDescription)")
        case 401: print("401 Unauthorized: \(error.localizedDescription)")
        case 403: print("403 Forbidden: \(error.localizedDescription)")
        case 404: print("404 Not Found: \(error.localizedDescription)")
        case 500: print("500 Internal Server Error: \(error.localizedDescription)")
        case 503: print("503 Service Unavailable: \(error.localizedDescription)")
        default:
            print("\(response.statusCode): \(error.localizedDescription)")
         }
        
        return appError
    }
}
