//
//  CardNetworkManager.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/08.
//

import Foundation
import Combine

protocol CardNetworkManagerProtocol: class {
    func getCards(state: CardState) -> AnyPublisher<Cards, Error>
    func postCard(columnId: Int, title: String, contents: String) -> AnyPublisher<Card, Error>
    func putCard(id: Int, title: String, contents: String) -> AnyPublisher<Card, Error>
    func removeCard(id: Int) -> AnyPublisher<Int, NetworkError>
    func move(id: Int, toColumnId: Int, toIndex: Int) -> AnyPublisher<Card, Error>
}

class CardNetworkManager: CardNetworkManagerProtocol {
    
    private var networkManager: HttpMethodProtocol!
    
    init(networkManager: HttpMethodProtocol) {
        self.networkManager = networkManager
    }
    
    convenience init() {
        let networkManager = NetworkManager()
        self.init(networkManager: networkManager)
    }
    
    func getCards(state: CardState) -> AnyPublisher<Cards, Error> {
        let endpoint = Endpoint.cards(state: state)
        return networkManager.get(type: Cards.self, url: endpoint.url)
    }
    
    func postCard(columnId: Int, title: String, contents: String) -> AnyPublisher<Card, Error> {
        let endpoint = Endpoint.add(columnId: columnId)
        
        return networkManager.post(title: title, contents: contents, url: endpoint.url)
    }
    
    func putCard(id: Int, title: String, contents: String) -> AnyPublisher<Card, Error> {
        let endpoint = Endpoint.update(id: id)
        
        return networkManager.put(title: title, contents: contents, url: endpoint.url)
    }
    
    func removeCard(id: Int) -> AnyPublisher<Int, NetworkError> {
        let endpoint = Endpoint.remove(id: id)
        
        return networkManager.delete(id: id, url: endpoint.url)
    }
    
    func move(id: Int, toColumnId: Int, toIndex: Int) -> AnyPublisher<Card, Error> {
        let endpoint = Endpoint.move(id: id, toColumn: toColumnId, toIndexOfColumn: toIndex)
        
        return networkManager.move(url: endpoint.url)
    }
}
