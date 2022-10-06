//
//  ViewController.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink

        let vc1 = UINavigationController(rootViewController: SeasonViewController())
        vc1.tabBarItem.image = UIImage(systemName: "lasso.and.sparkles")
        vc1.tabBarItem.title = "Season"

        setViewControllers([vc1], animated: true)
    }

}

