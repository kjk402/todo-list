//
//  BoardDataSource.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/16.
//

import UIKit

class BoardDataSource: NSObject {
    private var cardViewModel: CardViewModel!
    
    init(cardViewModel: CardViewModel) {
        self.cardViewModel = cardViewModel
    }
}

extension BoardDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardViewModel.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell else { return UICollectionViewCell() }

        cell.setup(with: self.cardViewModel, column: indexPath.item)
        cell.titleLabel.text = cardViewModel.boards[indexPath.item].getTitle()
        cell.boardCountLabel.text = "\(cardViewModel.boards[indexPath.item].getBoard().count())"
        cell.inputButton.tag = indexPath.row
        cell.inputButton.addTarget(self, action: #selector(cardAddButtonTapped(_:)), for: .touchUpInside)
        cell.tableView.identifier = indexPath.row
        
        return cell
    }
    
    @objc func cardAddButtonTapped(_ sender: UIButton) {
        guard let inputViewController = UIStoryboard(name: "Main", bundle: .none).instantiateViewController(identifier: "InputViewController") as? InputViewController else {
            return
        }
        inputViewController.modalPresentationStyle = .overCurrentContext
        inputViewController.setupMode("add")
        inputViewController.setupCardViewModel(self.cardViewModel)
        inputViewController.setupColumnId(sender.tag)
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(inputViewController, animated: false, completion: .none)
    }
}
