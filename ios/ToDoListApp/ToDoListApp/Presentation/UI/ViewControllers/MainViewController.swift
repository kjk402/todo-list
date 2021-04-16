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
    private var boardDataSource: BoardDataSource!
    private var subsciptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardViewModel = CardViewModel()
        self.boardDataSource = BoardDataSource(cardViewModel: self.cardViewModel)
        collectionView.dataSource = self.boardDataSource
        view.addSubview(historyView)
        self.historyView.isHidden = true
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
