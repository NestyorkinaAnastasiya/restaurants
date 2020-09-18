//
//  LoadFileError.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 18.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

enum AppError: Error {
    case dataNotFound
    case noInternet
    case unavailableServer
    
    var errorDescription: String {
        switch self {
        case .dataNotFound: return "We couldn't send your review. Please, enter your review and your nickname (athour)."
        case .noInternet: return "No internet."
        case .unavailableServer: return "Server is temporary unavailable."        
        }
    }
}
