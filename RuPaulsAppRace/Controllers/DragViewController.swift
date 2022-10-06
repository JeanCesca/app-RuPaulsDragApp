//
//  DragViewController.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import UIKit

class DragViewController: UIViewController {
    
    var seasonHeaderView = SeasonHeaderView()
    
    //cell model
    var cellViewModel: [SeasonCell.CellViewModel] = []
    
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
        
        view.backgroundColor = .systemTeal
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DragViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        dragViewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(dragViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "dragHeader") as! SeasonHeaderView
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
}
