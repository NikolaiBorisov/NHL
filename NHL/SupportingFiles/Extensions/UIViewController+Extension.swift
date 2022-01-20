//
//  UIViewController+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

// MARK: - Custom NavBar

extension UIViewController {
    
    func setupNavBarWith(title: String? = nil, font: UIFont? = UIFont.avenirNextDemiBoldOfSize(32), image: UIImage? = nil) {
        let appearance = UINavigationBarAppearance()
        guard let navBar = navigationController?.navigationBar else { return }
        self.title = title
        navigationItem.backButtonTitle = ""
        
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: font ?? .systemFont(ofSize: 35)
        ]
        appearance.backgroundImage = image
        
        navBar.tintColor = .black
        navBar.standardAppearance = appearance
        navBar.compactAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.prefersLargeTitles = true
    }
    
    func setupTabBarAppearance() {
        if #available(iOS 15.0, *) {
            guard let tabBar = tabBarController?.tabBar else { return }
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
}
