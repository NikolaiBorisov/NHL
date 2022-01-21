//
//  TabBarController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 03.01.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Private Properties
    
    private var coordinator: MainCoordinator
    private var screenFactory: ScreenFactory
    
    private lazy var middleButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(AppImage.nhlLogo, for: .normal)
        $0.layer.masksToBounds = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var customTabBarFrame: CustomTabBarView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CustomTabBarView())
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        screenFactory: ScreenFactory = ScreenFactoryImpl()
    ) {
        self.coordinator = coordinator
        self.screenFactory = screenFactory
        super.init(nibName: nil, bundle: nil)
        
        setupSelectedIndex()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator.start()
        setupTabBar()
        addSubviews()
        setupDelegate()
        setupLayout()
        setupView()
        setupTabBarScrollAppearance()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        tabBar.backgroundColor = .clear
    }
    
    private func setupDelegate() {
        delegate = self
    }
    
    private func setupSelectedIndex() {
        selectedIndex = 1
    }
    
    private func setupTabBar() {
        let gameVC = screenFactory.createGameScreen(coordinator: coordinator)
        let teamVC = coordinator.navigationController
        let playerVC = screenFactory.createPlayerByTeamScreen(coordinator: coordinator)
        viewControllers = [gameVC, teamVC, playerVC]
    }
    
    private func setupTabBarScrollAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    private func addSubviews() {
        view.addSubview(customTabBarFrame)
        tabBar.addSubview(middleButton)
        view.bringSubviewToFront(tabBar)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            middleButton.heightAnchor.constraint(equalToConstant: 40),
            middleButton.widthAnchor.constraint(equalToConstant: 40),
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10.0),
            
            customTabBarFrame.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            customTabBarFrame.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
            customTabBarFrame.widthAnchor.constraint(equalTo: tabBar.widthAnchor),
            customTabBarFrame.heightAnchor.constraint(equalTo: tabBar.heightAnchor)
        ])
    }
    
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    
}
