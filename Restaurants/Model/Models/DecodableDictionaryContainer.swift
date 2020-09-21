//
//  DecodableDictionaryContainer.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 21.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

struct DecodableDictionaryContainer<Key: Hashable, Value: Codable>: Codable where Key: CodingKey {
    var elements: [Value]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Key.self)
        let keys = container.allKeys

        var elements = [Value]()
        
        for key in keys {
            if let element = try? container.decode(Value.self, forKey: key) {
                elements.append(element)
            }
        }
        
        self.elements = elements
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }
}
