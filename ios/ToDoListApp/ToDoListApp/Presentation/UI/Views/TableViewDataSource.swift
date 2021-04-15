//
//  TableViewDataSource.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/13.
//

import UIKit
import Combine

class TableViewDataSource: NSObject {
    private var cardViewModel: CardViewModel!
    private var column: Int!
    
    private var loadDataSubject = PassthroughSubject<Void,Never>()
    private var subsciptions = Set<AnyCancellable>()
    
    init(cardViewModel: CardViewModel, column: Int) {
        self.cardViewModel = cardViewModel
        self.column = column
    }
}

extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewModel?.boards[column].count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as? CardCell else { return UITableViewCell() }
        
        cell.title = cardViewModel?.boards[column].getBoard().getCards()[indexPath.row].getTitle()
        cell.contents = cardViewModel?.boards[column].getBoard().getCards()[indexPath.row].getContents()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func bind(for willDeleteCard: CardManageable, indexOfColumn: Int) {
        cardViewModel?.removeEventListener(loadData: loadDataSubject.eraseToAnyPublisher(), willRemoveCardColumnId: column, willRemoveCard: willDeleteCard, indexOfColumn: indexOfColumn)
        
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            guard let card = cardViewModel?.boards[column].getBoard().getCards()[indexPath.row] else {
                return
            }
            bind(for: card, indexOfColumn: indexPath.row)
            loadDataSubject.send()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let movedCard = cardViewModel?.boards[column].getBoard().getCards()[sourceIndexPath.row] else { return }
        cardViewModel?.boards[column].getBoard().removeCard(at: sourceIndexPath.row)
        cardViewModel?.boards[column].getBoard().insertCard(card: movedCard, at: destinationIndexPath.row)
    }
}
