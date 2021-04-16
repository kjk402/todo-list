//
//  Done.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation

class Done: BoardManageable, CardFactory {
    private var board: Cards
    private let title = "완료한 일"
    private let column = 3
    
    init(board: Cards) {
        self.board = board
    }
    
    convenience init() {
        let board = Cards()
        self.init(board: board)
    }
    
    func getBoard() -> Cards {
        return self.board
    }
    
    func count() -> Int {
        return self.board.count()
    }
    
    func appendCard(_ card: Card) {
        self.board.appendCard(card)
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getCardTitle(index: Int) -> String {
        return self.board.getCards()[index].getTitle()
    }
    
    func getCardContents(index: Int) -> String {
        return self.board.getCards()[index].getContents()
    }
    
    func editCard(_ card: Card, index: Int) {
        self.board.editCard(at: index, for: card)
    }
    
    func boardCount() -> Int {
        return self.board.getCards().count
    }
    
    static func makeBoard(cards: Cards) -> BoardManageable {
        return Done(board: cards)
    }
    
    func getColumn() -> Int {
        return self.column
    }
    
    func insertCard(card: Card, at destinationIndex: Int) {
        self.board.insertCard(card: card, at: destinationIndex)
    }
}
