//
//  ViewController.swift
//  3rd_concentration
//
//  Created by ChenAlan on 2017/12/24.
//  Copyright © 2017年 ChenAlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Make contact to Model "Concentration"
    private lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return ((cardButtons.count+1) / 2)
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]! {
        didSet {
            chooseThemes()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        //flipCountLabel.text = "Flips: \(game.flipCount)"
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            scoreLabel.text = "Score: \(game.scores)"
            updateViewFromModel()
        } else {
           print("chosen card wass not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9818583131, green: 0.9282233715, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    // check if the theme is chosen
    var checkChosenTheme = 0
    
    //TODO: Make 6 themes
    private var emojiChoices = ""
    func chooseThemes() {
        let theme = ["sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸",
                     "cars": "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐",
                     "halloween": "👻🎃🍭🍬👿🦇🍎😱🙀☠",
                     "faces": "😄😇😍😎🤠🤡😂😡😰🤢",
                     "animals": "🐶🐭🐹🐼🐸🐷🐔🦄🦊🦁",
                     "fruits": "🍉🍇🍓🍋🥝🍒🍊🍌🍎🍑"]
        let themeKeys = Array(theme.keys)
        let themeIndex = Int(arc4random_uniform(UInt32(themeKeys.count)))
        emojiChoices = String(Array(theme.values)[themeIndex])
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        game.chosenBefore = Array(emoji.keys)
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            print(emojiChoices)
        }
        return emoji[card] ?? "?"
    }
    
    //TODO: "New Game" button
    @IBAction func startNewGame(_ sender: UIButton) {
        flipCount = 0
        game.scores = 0
        flipCountLabel.text = "Flips: 0"
        scoreLabel.text = "Score: 0"
        emoji = [Card:String]()
        chooseThemes()
        let randomIndex = game.cards.count.arc4random
        let shuffleCard = game.cards[0]
        game.cards[0] = game.cards[randomIndex]
        game.cards[randomIndex] = shuffleCard
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            game.indexOfOneAndOnlyFaceUpCard = nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

