//
//  HistoryCell.swift
//  ToDoListApp
//
//  Created by zombietux on 2021/04/14.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    static let reuseIdentifier = "HistoryCell"
    
    let imageView = UIImageView()
    let contentsLabel = UILabel()
    let authorLabel = UILabel()
    let createdAtLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        contentView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        contentsLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentsLabel.textColor = .black
        contentsLabel.numberOfLines = 3
        authorLabel.textColor = .darkGray
        createdAtLabel.textColor = .gray
        
        let textStack = UIStackView(arrangedSubviews: [authorLabel, contentsLabel, createdAtLabel])
        textStack.axis = .vertical
        textStack.alignment = .leading
        textStack.spacing = 12
        
        let historyStack = UIStackView(arrangedSubviews: [imageView, textStack])
        historyStack.axis = .horizontal
        historyStack.alignment = .top
        historyStack.spacing = 20
        
        contentView.addSubview(historyStack)
        historyStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            historyStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            historyStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            historyStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            historyStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25)
        ])
    }
}
