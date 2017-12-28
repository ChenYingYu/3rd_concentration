//
//  3rd_Concentration.swift
//  3rd_concentration
//
//  Created by ChenAlan on 2017/12/25.
//  Copyright © 2017年 ChenAlan. All rights reserved.
//

import Foundation

struct Concentration
{
    var cards = [Card]()
    
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    //TODO: Score rules
    var scores = 0
    //TODO: Penalize
    var chosenBefore = [Int]()

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "3rd_Contration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scores += 2
                } else {
                    for chosenIdentifier in chosenBefore.indices {
                        if cards[index].identifier == chosenBefore[chosenIdentifier] || cards[matchIndex].identifier == chosenBefore[chosenIdentifier] {
                            scores -= 1
                        }
                    }
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // Adding pairs of cards
    init(numberOfPairOfCards: Int) {
        assert(numberOfPairOfCards > 0, "3rd_Contration.init(\(numberOfPairOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        for _ in 1...numberOfPairOfCards {
        let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
        let shuffleCard = cards[0]
        cards[0] = cards[randomIndex]
        cards[randomIndex] = shuffleCard
    }
    }
}
