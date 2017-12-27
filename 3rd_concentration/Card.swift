//
//  Card.swift
//  3rd_concentration
//
//  Created by ChenAlan on 2017/12/25.
//  Copyright © 2017年 ChenAlan. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func gatUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.gatUniqueIdentifier()
    }
}
