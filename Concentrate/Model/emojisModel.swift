//
//  emojisModel.swift
//  Concentration
//
//  Created by David on 2018-06-14.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

struct Emoji {
    
//    enum Theme: Int {
//        case Family = 0
//        case Animals
//        case Space
//        case Weather
//        case Food
//        case Sports
//        case FamilyAgain
//    }
    
    let themes = ["Family", "Animals", "Space", "Weather", "Food", "Sports", "FamilyAgain"]
    
    let randomNumber = Int(arc4random_uniform(6))
    
    func selectEmojis(index: Int ) -> ([String],UIColor,UIColor) {
    
    var emojis: ([String],UIColor,UIColor)
    switch index{
    case 0:
        emojis = (["🤴🏻","👸🏻","🐶","💩","🐭","🐷","🐸","🐒"],#colorLiteral(red: 0.5582780242, green: 0.351790607, blue: 0.9695187211, alpha: 1),#colorLiteral(red: 0.002224128577, green: 0.00149387688, blue: 0.007396097716, alpha: 1))
    case 1:
        emojis = (["🦄","🐝","🦋","🦖","🦈","🐕","🐿","🐅"],#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    case 2:
        emojis = (["🌞","🌙","🌎","⭐️","☄️","💫","✨","🌚"],#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.5415090285, green: 0.783372048, blue: 0.8869858384, alpha: 1))
    case 3:
        emojis = (["⚡️","🔥","🌪","❄️","🌊","💧","💨","🌬"],#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
    case 4:
        emojis = (["🍆","🍑","🌭","🌮","🥝","🥖","🍩","🍔"],#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    case 5:
        emojis = (["🏋🏻‍♂️","🤼‍♀️","🏂","🏄🏻‍♂️","🏊🏻‍♀️","🤽🏻‍♀️","🚵🏻‍♀️","🧗🏻‍♂️"],#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    default :
        emojis = (["🤴🏻","👸🏻","🐶","💩","🐭","🐷","🐸","🐒"],#colorLiteral(red: 1, green: 0.9975826968, blue: 0.2638010982, alpha: 1),#colorLiteral(red: 0.5582780242, green: 0.351790607, blue: 0.9695187211, alpha: 1))
    }
    return emojis
    }
}
