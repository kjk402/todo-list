//
//  HistoryManageable.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import Foundation

protocol HistoryManageable: Decodable {
    func getTitle() -> String
}
