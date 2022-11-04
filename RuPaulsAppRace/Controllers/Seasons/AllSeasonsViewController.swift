//
//  HomeViewController.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import Foundation
import UIKit


class AllSeasonsViewController: UIViewController {
        
    //resquest model
    var allSeasons = [AllSeasons]()
    var singleSeason = [SingleSeason]()
    
    //cell view models
    var allSeasonsViewModel = [AllSeasonsViewModel]()
    var singleSeasonViewModel = [SingleSeasonViewModel]()
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AllSeasonsCell.self, forCellReuseIdentifier: AllSeasonsCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        configureConstraints()
        configureTableView()
        configureNavBar()
        fetchProfiles()
        
    }
    
    private func configureNavBar() {
        title = "Drag Race Seasons"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
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

//Networking
extension AllSeasonsViewController {
    private func fetchProfiles() {
        DragManager.shared.getAllSeasons { result in
            switch result {
            case .success(let allSeasonsFetched):
                self.allSeasons = allSeasonsFetched
                self.configureAllSeasons(with: self.allSeasons)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureAllSeasons(with model: [AllSeasons]) {
        allSeasonsViewModel = allSeasons.map ({ return AllSeasonsViewModel(with: $0) })
        tableView.reloadData()
    }
    
    private func configureSingleSeason(with model: [SingleSeason]) {
        singleSeasonViewModel = singleSeason.map ({ return SingleSeasonViewModel(with: $0) })
        tableView.reloadData()
    
    }
}

extension AllSeasonsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allSeasonsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllSeasonsCell.id, for: indexPath) as? AllSeasonsCell else {
            return UITableViewCell()
        }
                
        let allSeasonsViewModel = allSeasonsViewModel[indexPath.section]
        cell.configure(with: allSeasonsViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedSeason = allSeasonsViewModel[indexPath.section]
        let seasonNumber = selectedSeason.seasonNumber
            
        DragManager.shared.getAllDragsBySeason(seasonNumber: seasonNumber) { result in
            
            switch result {
            case .success(let singleSeasonFetched):
                self.singleSeason = singleSeasonFetched
                self.configureSingleSeason(with: self.singleSeason)
                
                let vc = SingleSeasonViewController()
                vc.singleSeasonViewModel = self.singleSeasonViewModel
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension AllSeasonsViewController {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(allSeasonsViewModel[section].seasonNumber)"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        Pegar a header de cada seção:
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 24, weight: .regular)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 60, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.localizedCapitalized
    }
}
