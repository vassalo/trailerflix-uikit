//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Daniel Vassalo on 14/11/22.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let viewsControllers = [
            UINavigationController(rootViewController: HomeViewController()),
            UINavigationController(rootViewController: UpcomingViewController()),
            UINavigationController(rootViewController: SearchViewController()),
            UINavigationController(rootViewController: DownloadsViewController())
        ]
        
        viewsControllers[0].tabBarItem.image = UIImage(systemName: "house")
        viewsControllers[1].tabBarItem.image = UIImage(systemName: "play.circle")
        viewsControllers[2].tabBarItem.image = UIImage(systemName: "magnifyingglass")
        viewsControllers[3].tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        viewsControllers[0].title = "Home"
        viewsControllers[1].title = "Coming soon"
        viewsControllers[2].title = "Top Search"
        viewsControllers[3].title = "Downloads"
        
        tabBar.tintColor = .label
        setViewControllers(viewsControllers, animated: true)
    }


}

