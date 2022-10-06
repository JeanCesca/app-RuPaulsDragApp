//
//  HomeViewController.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import Foundation
import UIKit

class SeasonViewController: UIViewController {
    
    //resquest model
    var profiles: [Profile] = []
    //cell model
    var cellViewModel: [SeasonCell.CellViewModel] = []
    //networking
    var dragManager = DragManager()
    //header
    var seasonHeaderView = SeasonHeaderView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SeasonCell.self, forCellReuseIdentifier: SeasonCell.cellID)
        tableView.register(SeasonHeaderView.self, forHeaderFooterViewReuseIdentifier: "dragHeader")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "rucolor")
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        
        tabBarController?.tabBar.barTintColor = UIColor(named: "rucolor")
        navigationController?.navigationBar.barTintColor = UIColor(named: "rucolor")
        
        fetchProfiles()
    }
}

//Networking
extension SeasonViewController {
    private func fetchProfiles() {
        dragManager.fetchDrag { result in
            switch result {
            case .success(let profilesFetched):
                self.profiles = profilesFetched
                self.configureTableCells(with: self.profiles)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureTableCells(with profiles: [Profile]) {
        cellViewModel = profiles.map({
            SeasonCell.CellViewModel(season: $0.seasonNumber, image_url: $0.image_url)
        })
        tableView.reloadData()
    }
}

extension SeasonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SeasonCell.cellID, for: indexPath) as! SeasonCell
        let profile = cellViewModel[indexPath.row]
        cell.configure(with: profile)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dragViewController = DragViewController()
        self.navigationController?.pushViewController(dragViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}

extension SeasonViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "dragHeader") as! SeasonHeaderView
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
}
