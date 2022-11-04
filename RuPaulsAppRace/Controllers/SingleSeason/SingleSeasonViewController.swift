//
//  DragViewController.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import UIKit

class SingleSeasonViewController: UIViewController {
    
    //single season view model
    var singleSeasonViewModel = [SingleSeasonViewModel]()
    
    //single season cell
    let singleSeasonTableViewCell = SingleSeasonCell()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SingleSeasonCell.self, forCellReuseIdentifier: SingleSeasonCell.id)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "All Drags in Season"
        
//        print("Texto passado para essa view: \(singleSeasonViewModel)")
            
        view.addSubview(tableView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SingleSeasonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //ajustar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleSeasonViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleSeasonCell.id, for: indexPath) as? SingleSeasonCell else {
            return UITableViewCell()
        }
                
        let singleSeasonViewModel = singleSeasonViewModel[indexPath.row]
        cell.configure(with: singleSeasonViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 640
    }
    
}
