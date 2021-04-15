//
//  HistoryViewController.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import UIKit
import Combine

class HistoryViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var historyViewModel: HistoryViewModel!
    private var cancellables: Set<AnyCancellable> = []
    private var historyCellRegistration: UICollectionView.CellRegistration<HistoryCell, History>!
    private let itemSize = (width: 300, height: 120)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyViewModel = HistoryViewModel()
        configureCollectionView()
        bind()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.view.isHidden = true
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120)
        ])
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        
        historyCellRegistration = UICollectionView.CellRegistration { cell, indexPath, history in
            cell.authorLabel.text = "@만사"
            cell.createdAtLabel.text = "1분전"
            cell.contentsLabel.text = "\(history.getTitle()),\(history.getAction())"
            cell.imageView.image = UIImage(named: "history")
        }
        
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.reuseIdentifier)
    }
    
    private func bind() {
        historyViewModel.dataChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        historyViewModel.fetchData()
    }
}

extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyViewModel.histories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let history = historyViewModel.histories[indexPath.row]
        return collectionView.dequeueConfiguredReusableCell(using: historyCellRegistration, for: indexPath, item: history)
    }
}

