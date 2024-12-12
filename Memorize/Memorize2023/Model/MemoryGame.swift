//
//  MemoryGame.swift
//  Memorize2023
//
//  Created by summer on 11/12/24.
//

import Foundation

struct MemoryGame<CardContent> {
    struct Card {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
    
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {}
}
