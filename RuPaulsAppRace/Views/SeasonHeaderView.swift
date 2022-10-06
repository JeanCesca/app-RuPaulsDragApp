//
//  SeasonHeaderView.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import Foundation
import UIKit

class SeasonHeaderView: UITableViewHeaderFooterView {
    
    let title = UILabel()
    let image = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        
        contentView.backgroundColor = .systemTeal
        contentView.addSubview(image)
        contentView.addSubview(title)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

