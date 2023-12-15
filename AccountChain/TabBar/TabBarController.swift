//
//  ViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit

class TabBarController: UITabBarController {

    let homeVC = HomeViewController()
    let passwordGeneratorVC = PasswordGeneratorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }

    func configView() {
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: passwordGeneratorVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Kartlarım", image: UIImage(named: "base_icon"), selectedImage: nil)
        nav2.tabBarItem = UITabBarItem(title: "Şifre oluştur", image: UIImage(named: "numpad_icon"), selectedImage: nil)
        
        setViewControllers([nav1, nav2], animated: true)
        tabBar.isTranslucent = false
        
        tabBar.backgroundColor = .gray
        tabBar.tintColor = UIColor(red: 0.06, green: 0.45, blue: 0.22, alpha: 1)
        
    }
}

