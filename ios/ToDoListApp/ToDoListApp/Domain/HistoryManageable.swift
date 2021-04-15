//
//  HistoryManageable.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import Foundation

protocol HistoryManageable {
    func getTitle() -> String
    func getAction() -> String
    func getFromColumnId() -> Int
    func getToColumnId() -> Int
}
