//
//  Card.swift
//  3rd_concentration
//
//  Created by ChenAlan on 2017/12/25.
//  Copyright © 2017年 ChenAlan. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func gatUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.gatUniqueIdentifier()
    }
}
