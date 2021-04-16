//
//  TableviewDelegate.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/13.
//

import UIKit

class TableViewDelegate: NSObject {
    enum Action {
        static let gotoDone = "완료한 일로 이동"
        static let edit = "완료한 일로 이동"
        static let delete = "완료한 일로 이동"
    }
    
    private var cardViewModel: CardViewModel!
    private var column: Int!
    
    init(cardViewModel: CardViewModel, column: Int) {
        self.cardViewModel = cardViewModel
        self.column = column
    }
    
    private func makeContextMenu(indexPath: IndexPath) -> UIMenu {
        let goToDone = UIAction(title: Action.gotoDone, image: .none) { action in
            let card = self.cardViewModel?.boards[self.column].getBoard().getCards()[indexPath.row]
            self.cardViewModel.moveCard(card as! CardManageable, beforeColumnId: self.column , beforeIndex: indexPath.row,  toColumnId: 3, toIndex: 0)
        }
        
        let edit = UIAction(title: Action.edit, image: .none) { action in
            self.gotoInputViewController(indexPath: indexPath)
        }
        
        let delete = UIAction(title: Action.delete, image: .none, attributes: .destructive) { action in
            let card = self.cardViewModel?.boards[self.column].getBoard().getCards()[indexPath.row]
            self.cardViewModel.removeCard(card: card as! CardManageable, columnId: self.column, index: indexPath.row)
        }
        
        return UIMenu(title: "", children: [goToDone, edit, delete])
    }
    
    private func gotoInputViewController(indexPath: IndexPath) {
        guard let inputViewController = UIStoryboard(name: "Main", bundle: .none).instantiateViewController(identifier: "InputViewController") as? InputViewController else {
            return
        }
        inputViewController.modalPresentationStyle = .overCurrentContext
        inputViewController.setupMode("edit")
        inputViewController.setupId(self.cardViewModel?.boards[self.column].getBoard().getCards()[indexPath.row].getId() ?? 0)
        inputViewController.setupCardViewModel(self.cardViewModel)
        inputViewController.setupWillEditCard(self.cardViewModel?.boards[self.column].getBoard().getCards()[indexPath.row] as! CardManageable)
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(inputViewController, animated: false, completion: .none)
    }
}

extension TableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: .none, previewProvider: .none) { suggestedAction -> UIMenu? in
            return self.makeContextMenu(indexPath: indexPath)
        }
    }
}
