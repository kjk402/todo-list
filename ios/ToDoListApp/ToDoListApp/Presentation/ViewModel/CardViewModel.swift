//
//  ToDoViewModel.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/07.
//

import Foundation
import Combine

class CardViewModel {
    private var cardUseCase: CardUseCasePort
    
    @Published var boards: [BoardManageable] = []

    var reloadCardList: AnyPublisher<Result<Void, Error>, Never> { reloadCardListSubject.eraseToAnyPublisher() }
    private var subscriptions = Set<AnyCancellable>()
    private var loadData: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    private let reloadCardListSubject = PassthroughSubject<Result<Void, Error>, Never>()
        
    init(cardUseCase: CardUseCasePort) {
        self.cardUseCase = cardUseCase
    }
    
    convenience init() {
        let cardUseCase = CardUseCase()
        self.init(cardUseCase: cardUseCase)
    }
    
    func isEnabledCardEnrollemnt(count: Int) -> Bool {
        return self.cardUseCase.isEnabledCardEnrollemnt(count: count)
    }
    
    private func configureBoard(type: CardFactory.Type, cards: AnyPublisher<Cards, Error>) {
        cards
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result)
                    in switch result {
                    case .finished: print("finished")
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { (cards) in
                    self.boards.append(type.self.makeBoard(cards: cards))
                    self.boards.sort(by: { $0.getColumn() < $1.getColumn() })
                  })
            
            .store(in: &subscriptions)
    }
 
    func requestBoard() {
        
        self.configureBoard(type: ToDo.self, cards: self.cardUseCase.get(state: .todo))
        self.configureBoard(type: Doing.self, cards: self.cardUseCase.get(state: .doing))
        self.configureBoard(type: Done.self, cards: self.cardUseCase.get(state: .done))
    }

    
    func addCard(columnId: Int, title: String, contents: String) {
        cardUseCase.add(columnId: columnId, title: title, contents: contents)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: print("finished")
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { card in
                    self.boards[columnId].appendCard(card)
                    self.reloadCardListSubject.send(.success(()))
                  })
            .store(in: &subscriptions)
    }
    
    func editCard(card: CardManageable, toBeTitle: String, toBeContents: String) {
        cardUseCase.edit(id: card.getId()!, title: toBeTitle, contents: toBeContents)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: print("finished")
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { _ in
                    card.edit(title: toBeTitle, contents: toBeContents)
                    self.reloadCardListSubject.send(.success(()))
                   
                  })
            .store(in: &subscriptions)
    }
    
    func removeCard( card: CardManageable, columnId: Int, index: Int) {
        subscriptions.removeAll()
        
        cardUseCase.remove(id: card.getId() ?? 0)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: print("finished")
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { _ in
                    self.boards[columnId].getBoard().removeCard(at: index ?? 0)
                    self.reloadCardListSubject.send(.success(()))
                  })
            .store(in: &subscriptions)
    }
    
    func addEventListener(loadData: AnyPublisher<Void, Never>, columnId: Int, title: String, contents: String) {
        
        self.loadData = loadData
        self.loadData
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] cards in
                    print("addEventListener:  \(cards)")
                    self?.addCard(columnId: columnId, title: title, contents: contents)
                  })
                    .store(in: &subscriptions)
            }
            
    func editEventListener(loadData: AnyPublisher<Void, Never>, willEditCard: CardManageable, toBeTitle: String, toBeContents: String) {
        
        self.loadData = loadData
        self.loadData
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: print("finished")
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { [weak self] cards in
                    print("editEventListener: \(cards)")
                    self?.editCard(card: willEditCard, toBeTitle: toBeTitle, toBeContents: toBeContents)
                  })
            .store(in: &subscriptions)
    }
            
    func removeEventListener(loadData: AnyPublisher<Void, Never>, willRemoveCardColumnId: Int, willRemoveCard: CardManageable, indexOfColumn: Int) {
 
        subscriptions.removeAll()
  
        self.loadData = loadData
        self.loadData
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: print("finished")
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { [weak self] card in
                    print("removeEventListener: \(card)")
                    self?.removeCard(card: willRemoveCard, columnId: willRemoveCardColumnId, index: indexOfColumn)
                    
                  })
            .store(in: &subscriptions)
    }
    
    func moveCard(_ card: CardManageable, beforeColumnId: Int, beforeIndex: Int ,toColumnId: Int, toIndex: Int) {
        cardUseCase.move(id: card.getId() ?? 0, toColumnId: toColumnId, toIndex: toIndex)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                    switch result {
                    case .finished: print("finished")
                    case .failure(let error): print(error.localizedDescription) } },
                  receiveValue: { movedCard in
                  print(movedCard)
                    self.boards[toColumnId-1].insertCard(card: movedCard, at: toIndex)
                    self.boards[beforeColumnId].getBoard().removeCard(at: beforeIndex ?? 0)
                    self.reloadCardListSubject.send(.success(()))
                  })
            .store(in: &subscriptions)
    }
}
