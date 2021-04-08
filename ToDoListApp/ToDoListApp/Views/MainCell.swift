//
//  MainCell.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/07.
//

import UIKit

class MainCell: UICollectionViewCell {
    static let identifier = "MainCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var board: Board?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
    }
    
    func setup(with board: Board) {
        self.board = board
        tableView.reloadData()
    }
}

extension MainCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else { return UITableViewCell() }
        cell.titleLabel?.text = board?.items[indexPath.row]
        return cell
    }
}
