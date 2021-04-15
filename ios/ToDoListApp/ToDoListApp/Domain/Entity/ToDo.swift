//
//  ToDo.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation

protocol CardFactory {
    static func makeBoard(cards: Cards) -> BoardManageable
}

class ToDo: BoardManageable, CardFactory {

    private var board: Cards
    private let title = "해야하는 일"
    
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
    
    func editCard(_ card: Card, index: Int) {
        self.board.editCard(at: index, for: card)
    }
    
    static func makeBoard(cards: Cards) -> BoardManageable {
        return ToDo(board: cards)
    }
}
