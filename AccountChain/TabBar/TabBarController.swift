//
//  ViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit

class TabBarController: UITabBarController {

    let homeVC = HomeViewController()
    let newCardVC = NewCardViewController()
    let passwordGeneratorVC = PasswordGeneratorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    func configView() {
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: newCardVC)
        let nav3 = UINavigationController(rootViewController: passwordGeneratorVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Kartlarım", image: UIImage(named: "safe_card_icon"), selectedImage: nil)
        nav2.tabBarItem = UITabBarItem(title: "Kart Oluştur", image: UIImage(named: "plus-circle"), selectedImage: nil)
        nav3.tabBarItem = UITabBarItem(title: "Şifre oluştur", image: UIImage(named: "numpad_icon"), selectedImage: nil)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        tabBar.isTranslucent = false
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "tab_bar_color")
        
    }
}

