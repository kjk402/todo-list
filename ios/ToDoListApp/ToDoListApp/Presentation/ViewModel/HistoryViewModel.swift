//
//  HistoryViewModel.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import Foundation
import Combine

class HistoryViewModel {
    @Published var histories: [History] = []
    private(set) var dataChanged = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var historyUseCase: HistoryUseCasePort!
    
    init(historyUseCase: HistoryUseCasePort) {
        self.historyUseCase = historyUseCase
    }
    
    convenience init() {
        let historyUseCase = HistoryUseCase()
        self.init(historyUseCase: historyUseCase)
    }
    
    func fetchData() {
        let historiesPub = historyUseCase.get()
        historiesPub
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result)
                    in switch result {
                    case .finished: break
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { histories in
                    self.histories = histories
                    self.dataChanged.send()
                  })
            
            .store(in: &cancellables)
    }
}
