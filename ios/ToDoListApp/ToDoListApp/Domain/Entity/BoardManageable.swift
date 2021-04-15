//
//  BoardManageable.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation

protocol BoardManageable {
    func getBoard() -> Board
    func getTitle() -> String
    func count() -> Int
    func forEachCards(handler: (CardManageable) -> ())
    func appendCard(_ card: CardManageable)
    func getColumn() -> Int
    func insertCard(card: CardManageable, at destinationIndex: Int) 
    //func editCard(title: String, contents: String)
}
