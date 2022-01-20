//
//  Router.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 30.12.2021.
//

import UIKit

protocol Router {
    var navigationController: UINavigationController { get set }
    func start()
}

extension Router {
    
    func dismissController(animated: Bool) {
        navigationController.dismiss(animated: animated)
    }
    
    func popController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func presentController(controller: UIViewController, animated: Bool) {
        navigationController.showDetailViewController(controller, sender: navigationController)
    }
    
    func pushController(controller: UIViewController, animated: Bool) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
}
