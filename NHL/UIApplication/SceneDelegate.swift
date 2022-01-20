//
//  SceneDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public Properties
    
    public var window: UIWindow?
    
    // MARK: - Private Properties
    
    private var config = Realm.Configuration()
    
    private let coordinator: MainCoordinator = {
        let nc = UINavigationController()
        return MainCoordinatorImpl(navigationController: nc)
    }()
    
    // MARK: - Public Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createInitialViewController()
        window?.makeKeyAndVisible()
        
        getPathToRealmFile()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    // MARK: - Private Methods
    
    private func createInitialViewController() -> UIViewController {
        return TabBarController(coordinator: coordinator)
    }
    
    private func getPathToRealmFile() {
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("contact.realm")
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "none")
    }
    
}
