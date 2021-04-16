//
//  ToDoUseCasePort.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/06.
//

import Foundation
import Combine

protocol CardManageable: Codable {
    func add()
    func edit(title: String, contents: String)
    func delete()
    func goToDone()
    func getTitle() -> String
    func getContents() -> String
    func getId() -> Int?
}

protocol CardUseCasePort {
    func add(columnId: Int, title: String, contents: String) -> AnyPublisher<Card, Error>
    func edit(id: Int, title: String, contents: String) -> AnyPublisher<Card, Error>
    func get(state: CardState) -> AnyPublisher<Cards, Error>
    func isEnabledCardEnrollemnt(count: Int) -> Bool
    func remove(id: Int) -> AnyPublisher<Int, NetworkError>
    func move(id: Int, toColumnId: Int, toIndex: Int) -> AnyPublisher<Card, Error>
}
