//
//  ViewController.swift
//  Concentrate
//
//  Created by David on 2018-11-13.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get { return (cardButtons.count + 1) / 2}
    }
    //    var emojis:Emoji = Emoji()
    private var emojiChoices: ([String],UIColor,UIColor) = Emoji.init().selectEmojis()
    private var emoji = [Card:String]()
 
    @IBAction private func newGameButton(_ sender: UIButton) {
        
        emoji = [:]
        emojiChoices = Emoji.init().selectEmojis()
        game.resetGame()
        updateLabels()
        updateViewFromModel()
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var flipCounter: UILabel!
    @IBOutlet weak var scoreCounter: UILabel!
    
    private func updateLabels() {
        //  score label
        scoreCounter.backgroundColor = emojiChoices.2
        scoreCounter.textColor = emojiChoices.1
        scoreCounter.text = "Score: \(game.score)"
        // flipcount label
        flipCounter.backgroundColor = emojiChoices.2
        flipCounter.textColor = emojiChoices.1
        flipCounter.text = "Flip Count: \(game.flipCount)"
        // New game label
        newGameButton.backgroundColor = emojiChoices.2
        newGameButton.titleLabel?.textColor = emojiChoices.1
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipcounting()
        updateLabels()
        
        if let cardNumber = cardButtons.index(of: sender){
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    private func updateViewFromModel() {
        self.view.backgroundColor = emojiChoices.2
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.9975826968, blue: 0.2638010982, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.5582780242, green: 0.351790607, blue: 0.9695187211, alpha: 0) : emojiChoices.1
            }
        }
    }
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.0.count > 0  {
            emoji[card] = emojiChoices.0.remove(at: emojiChoices.0.count.arc4random)
        }
        
        //  the code below is the same as the return stament that follows it.
        //        if emoji[card.identifier] != nil {
        //            return emoji[card.identifier]!
        //        } else {
        //            return "?"
        //        }
        return emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

