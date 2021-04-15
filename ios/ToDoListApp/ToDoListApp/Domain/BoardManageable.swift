//
//  BoardManageable.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation

protocol BoardManageable {
    func getBoard() -> Cards
    func getTitle() -> String
    func count() -> Int
    func appendCard(_ card: Card)
}
