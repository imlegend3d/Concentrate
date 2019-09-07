//
//  ConcentrationModel.swift
//  Concentration
//
//  Created by David on 2018-06-08.
//  Copyright © 2018 David. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    var score: Int = 0
    var flipCount: Int = 0
    mutating func flipcounting() {
        flipCount += 1
    }
    
    private var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp}.oneAndOnly
            
//          the code 2 line code below is the same as the one line above if the extension at the bottom exist.
//            let faceUpCardIndices = cards.indices.filter {cards[$0].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
 
        //  the 11 lines of code below is the same as the 2 lines above.
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
   mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 3
                } else if cards[index].selectedBefore == true {
                    score -= 1
                }
                cards[index].isFaceUp = true
                 
            } else {
                indexOfOneAndOnlyOneFaceUpCard = index
                if cards[index].selectedBefore == true {
                    score -= 1
                }
            }
            cards[index].selectedBefore = true
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
        cards += [card, card]
        }
        // TODO: shuffle the cards
    
        cards.shuffle()
    }
    
    mutating func resetGame() {
        score = 0
        flipCount = 0
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
            cards[index].selectedBefore = false 
        }
        indexOfOneAndOnlyOneFaceUpCard = nil
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}


