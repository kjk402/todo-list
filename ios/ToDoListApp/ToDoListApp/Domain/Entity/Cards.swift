//
//  Cards.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/12.
//

import Foundation

class Cards: Codable {
    private var cards: [Card]
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    convenience init() {
        let cards = [Card]()
        self.init(cards: cards)
    }
    
    func count() -> Int {
        return self.cards.count
    }
    
    func getCards() -> [Card] {
        return self.cards
    }
    
    func getCardTitle(index: Int) -> String {
        return self.cards[index].getTitle()
    }
    
    func getCardContents(index: Int) -> String {
        return self.cards[index].getContents()
    }
    
    func appendCard(_ card: Card) {
        self.cards.append(card)
    }
    
    func removeCard(at index: Int) {
        self.cards.remove(at: index)
    }
    
    func insertCard(card: Card, at destinationIndex: Int) {
        self.cards.insert(card, at: destinationIndex)
    }
    
    func editCard(at index: Int, for card: Card) {
        self.cards[index] = card
    }
}
