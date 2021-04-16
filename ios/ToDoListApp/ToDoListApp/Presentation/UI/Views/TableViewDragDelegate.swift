//
//  TableviewDragDelegate.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/13.
//

import UIKit

class TableViewDragDelegate: NSObject {
    private var cardViewModel: CardViewModel!
    private var column: Int
    private var collectionView: UICollectionView!
    
    init(cardViewModel: CardViewModel, column: Int) {
        self.cardViewModel = cardViewModel
        self.column = column
    }
}

extension TableViewDragDelegate: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let provider = NSItemProvider()
        let item = UIDragItem(itemProvider: provider)
        
        if let myTableView = tableView as? MyTableView {
            item.localObject = (cardViewModel.boards[column].getBoard().getCards()[indexPath.row], myTableView.identifier, indexPath.row)
        }
        
        return [item]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let dragItems = coordinator.session.localDragSession?.items else {
            return
        }
        
        let beforeCardsAndColumnAndIndex = dragItems.compactMap {
            return $0.localObject as? (Card, Int, Int)
        }
        
        guard let beforeCardAndColumnAndIndex = beforeCardsAndColumnAndIndex.first else {
            return
        }
        
        guard let myTableView = tableView as? MyTableView else {
            return
        }
       
        cardViewModel.moveCard(beforeCardAndColumnAndIndex.0, beforeColumnId: beforeCardAndColumnAndIndex.1, beforeIndex: beforeCardAndColumnAndIndex.2, toColumnId: myTableView.identifier+1, toIndex: coordinator.destinationIndexPath?.row ?? 0)
    }
}
