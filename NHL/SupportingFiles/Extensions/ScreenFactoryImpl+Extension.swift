//
//  ScreenFactoryImpl+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 03.01.2022.
//

import UIKit

// MARK: - Create NavigationController

extension ScreenFactoryImpl {
    
    func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage? = nil
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
}
