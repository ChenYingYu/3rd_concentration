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
        return (cardButtons.count+1 / 2)
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    


    @IBAction private func touchCard(_ sender: UIButton) {
        if checkChosenTheme == 0 {
            chooseThemes(at: 1)
        }
        game.flipCount += 1
        flipCountLabel.text = "Flips: \(game.flipCount)"
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
    private var emojiChoices = [String]()
    func chooseThemes(at index: Int) {
        var themeIndex = index
        checkChosenTheme = 1
        let theme = ["sports": ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"],
                     "cars": ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"],
                     "halloween": ["👻","🎃","🍭","🍬","👿","🦇","🍎","😱","🙀","☠"],
                     "faces": ["😄","😇","😍","😎","🤠","🤡","😂","😡","😰","🤢"],
                     "animals": ["🐶","🐭","🐹","🐼","🐸","🐷","🐔","🦄","🦊","🦁"],
                     "fruits": ["🍉","🍇","🍓","🍋","🥝","🍒","🍊","🍌","🍎","🍑"]]
        let themeKeys = Array(theme.keys)
        themeIndex = Int(arc4random_uniform(UInt32(themeKeys.count)))
        emojiChoices = Array(theme.values)[themeIndex]
    }
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        game.chosenBefore = Array(emoji.keys)
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    //TODO: "New Game" button
    @IBAction func startNewGame(_ sender: UIButton) {
        game.flipCount = 0
        game.scores = 0
        flipCountLabel.text = "Flips: 0"
        scoreLabel.text = "Score: 0"
        emoji = [Int:String]()
        chooseThemes(at: 1)
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

