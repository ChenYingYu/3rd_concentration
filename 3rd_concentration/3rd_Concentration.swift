//
//  3rd_Concentration.swift
//  3rd_concentration
//
//  Created by ChenAlan on 2017/12/25.
//  Copyright © 2017年 ChenAlan. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    //TODO: Score rules
    var scores = 0
    //TODO: Penalize
    var chosenBefore = [Int]()

    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scores += 2
                    print("matched identifier = \(cards[index].identifier)")
                } else {
                    for chosenIdentifier in chosenBefore.indices {
                        if cards[index].identifier == chosenBefore[chosenIdentifier] || cards[matchIndex].identifier == chosenBefore[chosenIdentifier] {
                            scores -= 1
                        }
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // Adding pairs of cards
    init(numberOfPairOfCards: Int) {
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
