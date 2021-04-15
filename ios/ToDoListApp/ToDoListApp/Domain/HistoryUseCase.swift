//
//  HistoryUseCase.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import Foundation
import Combine

class HistoryUseCase: HistoryUseCasePort {
    private var historyNetworkManager: HistoryNetworkManagerProtocol
    
    init(historyNetworkManager: HistoryNetworkManagerProtocol) {
        self.historyNetworkManager = historyNetworkManager
    }
    
    convenience init() {
        let historyNetworkManager = HistoryNetworkManager()
        self.init(historyNetworkManager: historyNetworkManager)
    }
    
    func get() -> AnyPublisher<[History], Error> {
        return historyNetworkManager.getHistories()
    }
}
