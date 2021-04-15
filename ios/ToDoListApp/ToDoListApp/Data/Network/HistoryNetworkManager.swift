//
//  HistoryNetworkManager.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import Foundation
import Combine

protocol HistoryNetworkManagerProtocol: class {
    var networkManager: HttpMethodProtocol { get }

    func getHistories() -> AnyPublisher<[History], Error>
}

class HistoryNetworkManager: HistoryNetworkManagerProtocol {
    var networkManager: HttpMethodProtocol
    
    init(networkManager: HttpMethodProtocol) {
        self.networkManager = networkManager
    }
    
    convenience init() {
        let networkManager = NetworkManager()
        self.init(networkManager: networkManager)
    }
    
    func getHistories() -> AnyPublisher<[History], Error> {
        let endpoint = Endpoint.histories()
        return networkManager.get(type: [History].self, url: endpoint.url)
    }
}
