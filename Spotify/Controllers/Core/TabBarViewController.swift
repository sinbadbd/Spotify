//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = LibraryViewController()
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        
        nav1.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        nav1.navigationBar.prefersLargeTitles = true
        
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        nav2.navigationBar.prefersLargeTitles = true
        
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "building.columns"), selectedImage: UIImage(systemName: "building.columns.fill"))
        nav3.navigationBar.prefersLargeTitles = true
        
        
        setViewControllers([nav1,nav2,nav3], animated: true)
 
    }
    
 

}
