//
//  MainViewController.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/07.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var historyView: UIView!
    
    private var cardViewModel: CardViewModel!
    private var subsciptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        view.addSubview(historyView)
        self.historyView.isHidden = true
        self.cardViewModel = CardViewModel()
        cardViewModel.requestBoard()
        bind()
    }
    
    func bind() {
        cardViewModel.$boards
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue:{ [weak self] _ in self?.collectionView.reloadData() })
            .store(in: &self.subsciptions)
        
        cardViewModel?.reloadCardList
            .sink(receiveCompletion: { completion in
            }) { [weak self] _ in
                self?.collectionView?.reloadData()
            }
            .store(in: &subsciptions)
    }
    
    @IBAction func historyViewOpenButtonTapped(_ sender: Any) {
        self.historyView.isHidden = false
    }
    
    @IBAction func historyViewCloseButtonTaeppd(_ sender: Any) {
        self.historyView.isHidden = true
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        guard let inputViewController = self.storyboard?.instantiateViewController(withIdentifier: "InputViewController") as? InputViewController else { return }
        inputViewController.modalPresentationStyle = .overCurrentContext
        inputViewController.setupMode("add")
        inputViewController.setupCardViewModel(self.cardViewModel)
        inputViewController.setupColumnId(sender.tag)
        present(inputViewController, animated: false, completion: nil)
    }
}
