//
//  ViewController.swift
//  Concentrate
//
//  Created by David on 2018-11-13.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class ConcentrationVC: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var selectedNumber: Int? = 0
    
    var numberOfPairsOfCards: Int {
        get { return (cardButtons.count + 1) / 2}
    }
    //    var emojis:Emoji = Emoji()
    private var emojiChoices: ([String],UIColor,UIColor)?
    private var emoji = [Card:String]()
    
    
    var theme: ([String],UIColor,UIColor)? {
        didSet{
            emojiChoices = theme!
            emoji = [:]
            updateViewFromModel()
        }
    }
 
    @IBAction private func newGamePressed(_ sender: UIButton) {
        
        emoji = [:]
        emojiChoices = Emoji.init().selectEmojis(index: selectedNumber!)
        game.resetGame()
        updateLabels()
        updateViewFromModel()
    }
    
    @IBOutlet weak var newGameButton: UIButton! {
        didSet {
            newGameButton.layer.backgroundColor = UIColor.clear.cgColor
            newGameButton.layer.cornerRadius = 10
            newGameButton.layer.borderWidth = 4
            newGameButton.layer.borderColor = emojiChoices?.2 == #colorLiteral(red: 0.002224128577, green: 0.00149387688, blue: 0.007396097716, alpha: 1) ? UIColor.white.cgColor : UIColor.black.cgColor
        }
    }
    @IBOutlet weak var flipCounter: UILabel!
    @IBOutlet weak var scoreCounter: UILabel!
    
    private func updateLabels() {
        //  score label
        scoreCounter.backgroundColor = emojiChoices?.2
        scoreCounter.textColor = emojiChoices?.1
        scoreCounter.text = "Score: \(game.score)"
        // flipcount label
        flipCounter.backgroundColor = emojiChoices?.2
        flipCounter.textColor = emojiChoices?.1
        flipCounter.text = "Flip Count: \(game.flipCount)"
        // New game label
        newGameButton.backgroundColor = emojiChoices?.2
        newGameButton.setTitleColor(emojiChoices?.1, for: .normal)
        
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]! {
        didSet {
            for button in cardButtons {
                button.layer.cornerRadius = 10
                button.layer.borderWidth = 4
                button.layer.borderColor = emojiChoices?.2 == #colorLiteral(red: 0.002224128577, green: 0.00149387688, blue: 0.007396097716, alpha: 1) ? UIColor.white.cgColor : UIColor.black.cgColor
            }
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipcounting()
        updateLabels()
        
        if let cardNumber = cardButtons.firstIndex(of: sender){
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    private func updateViewFromModel() {
        self.view.backgroundColor = emojiChoices?.2
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle( emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.9975826968, blue: 0.2638010982, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.5582780242, green: 0.351790607, blue: 0.9695187211, alpha: 0) : emojiChoices?.1
            }
        }
    }
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil ,(emojiChoices?.0.count)! > 0   {
            let count = emojiChoices!.0.count
            emoji[card] = emojiChoices?.0.remove(at: count.arc4random)
        }
    
        return emoji[card] ?? "?"
    }
    
    private func setUpViews() {
        guard let selectedNumber = selectedNumber else {return}
        emoji = [:]
        emojiChoices = Emoji.init().selectEmojis(index: selectedNumber)
        game.resetGame()
        updateViewFromModel()
        updateLabels()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateLabels()
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

