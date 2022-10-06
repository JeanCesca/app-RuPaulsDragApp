//
//  CellDragData.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import Foundation
import UIKit

class SeasonCell: UITableViewCell {
    
    let dragManager = DragManager()
    
    static let cellID = "SeasonCell"
    
    let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let seasonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private func configureConstraints() {
        let seasonLabelCons = [
            seasonLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            seasonLabel.topAnchor.constraint(equalTo: topAnchor),
        ]
        
        let seasonImageCons = [
            seasonImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            seasonImage.topAnchor.constraint(equalTo: topAnchor),
            seasonImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            seasonImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(seasonLabelCons)
        NSLayoutConstraint.activate(seasonImageCons)
    }
    
    struct CellViewModel {
        let season: String
        let image_url: String
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(seasonLabel)
        contentView.addSubview(seasonImage)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with vm: CellViewModel) {
        seasonLabel.text = "Season \(vm.season)"
        seasonImage.image = UIImage(systemName: "person.fill")
//        seasonImage.image = dragManager.getImage(from: vm.image_url)
    }
}
