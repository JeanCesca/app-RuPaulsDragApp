//
//  CellDragData.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import Foundation
import UIKit
import SDWebImage

class AllSeasonsCell: UITableViewCell {
    
    static let id = "SeasonCell"
    
    let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .systemPink
        return label
    }()
    
    let seasonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func configureConstraints() {
        let seasonLabelCons = [
            seasonLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            seasonLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let seasonImageCons = [
            seasonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seasonImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            seasonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(seasonLabelCons)
        NSLayoutConstraint.activate(seasonImageCons)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(seasonImage)
        contentView.addSubview(seasonLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with vm: AllSeasonsViewModel) {
        
        guard let url = URL(string: vm.seasonImage) else { return }
        seasonImage.sd_setImage(with: url)
    }
}
