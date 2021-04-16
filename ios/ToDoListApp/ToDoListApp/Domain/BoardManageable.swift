//
//  BoardManageable.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation

protocol BoardManageable {
    func getBoard() -> Cards
    func boardCount() -> Int
    func getCardTitle(index: Int) -> String
    func getCardContents(index: Int) -> String
    func getTitle() -> String
    func count() -> Int
    func appendCard(_ card: Card)
    func getColumn() -> Int
    func insertCard(card: Card, at destinationIndex: Int)
}
