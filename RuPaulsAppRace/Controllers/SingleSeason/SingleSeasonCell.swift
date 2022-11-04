//
//  SingleSeasonView.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 07/10/22.
//

import Foundation
import UIKit
import SDWebImage

class SingleSeasonCell: UITableViewCell {
    
    static let id: String = "SingleSeasonTableViewCell"
    
    private let dragImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.adjustsImageSizeForAccessibilityContentSizeCategory = true
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(systemName: "person")
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome da dreigui"
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quote da dreigui"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dragImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(quoteLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            
            quoteLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            quoteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dragImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dragImage.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 8),
            dragImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dragImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with vm: SingleSeasonViewModel) {
        //image using SDWebImage
        guard let url = URL(string: vm.image_url) else { return }
        dragImage.sd_setImage(with: url)
        //nome e quote
        nameLabel.text = vm.getWinner(winner: vm.winner)
        quoteLabel.text = vm.quote
    }
}
