//
//  ToDoUseCasePort.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/06.
//

import Foundation
import Combine

protocol CardManageable: Decodable {
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
    func get(state: State) -> AnyPublisher<Cards, Error>
    func isEnabledCardEnrollemnt(count: Int) -> Bool
}
