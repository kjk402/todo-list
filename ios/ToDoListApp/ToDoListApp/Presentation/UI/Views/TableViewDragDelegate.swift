//
//  TableviewDragDelegate.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/13.
//

import UIKit

class TableViewDragDelegate: NSObject {
    
}

extension TableViewDragDelegate: UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            //print(destinationIndexPath)
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            
        }
        //print(destinationIndexPath)
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print(coordinator.destinationIndexPath,"드롭")
        print(coordinator.items)
        print(tableView)
    }
}

