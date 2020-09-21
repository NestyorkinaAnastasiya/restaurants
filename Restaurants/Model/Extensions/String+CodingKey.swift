//
//  String+CodingKey.swift
//  Restaurants
//
//  Created by Anastasia Nesterkina on 21.09.2020.
//  Copyright © 2020 Anastasia Nesterkina. All rights reserved.
//

import Foundation

extension String: CodingKey {
    public var stringValue: String {
        return self
    }
    public var intValue: Int? {
        return Int(self)
    }
    public init?(intValue: Int) {
        self.init()
        self = String(intValue)
    }
    public init?(stringValue: String) {
        self.init()
        self = stringValue
    }
}
