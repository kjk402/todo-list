//
//  ToDoUseCase.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/06.
//

import Foundation
import Combine

class CardUseCase: CardUseCasePort {
    enum NotificationName {
        static let didUpdateTextField = Notification.Name("didUpdateTextField")
    }
    
    private var card: CardManageable
    private var toDo: BoardManageable
    private var doing: BoardManageable
    private var done: BoardManageable
    private var cardNetworkManager: CardNetworkManagerProtocol
    private var isEnabledInCardEnrollemnt = [false, false]
    
    init(card: CardManageable, toDo: BoardManageable, doing: BoardManageable, done: BoardManageable, cardNetworkManager: CardNetworkManagerProtocol) {
        self.card = card
        self.toDo = toDo
        self.doing = doing
        self.done = done
        self.cardNetworkManager = cardNetworkManager
    }
    
    convenience init() {
        let card = Card()
        let toDo = ToDo()
        let doing = Doing()
        let done = Done()
        let cardNetworkManager = CardNetworkManager()
        self.init(card: card, toDo: toDo, doing: doing, done: done, cardNetworkManager: cardNetworkManager)
    }

    func get(state: CardState) -> AnyPublisher<Cards, Error> {
        return cardNetworkManager.getCards(state: state)
    }
 
    func add(columnId: Int, title: String, contents: String) -> AnyPublisher<Card, Error>  {
        return cardNetworkManager.postCard(columnId: columnId, title: title, contents: contents)
    }
    
    func edit(id: Int, title: String, contents: String) -> AnyPublisher<Card, Error> {
        return cardNetworkManager.putCard(id: id, title: title, contents: contents)
    }
    
    func isEnabledCardEnrollemnt(count: Int) -> Bool {
        return count > 0
    }
    
    func remove(id: Int) -> AnyPublisher<Int, NetworkError> {
        return cardNetworkManager.removeCard(id: id)
    }
    
    func move(id: Int, toColumnId: Int, toIndex: Int) -> AnyPublisher<Card, Error> {
        return cardNetworkManager.move(id: id, toColumnId: toColumnId, toIndex: toIndex)
    }
}
