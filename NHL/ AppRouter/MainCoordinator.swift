//
//  MainCoordinator.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 30.12.2021.
//

import UIKit

protocol MainCoordinator: Router {
    func pushDetailedScreenWith(team: DetailedTeamScreenModelProtocol)
    func pushPlayerRosterScreenWith(
        players: TeamRoster,
        abbreviation: String
    )
}

/// Class coordinates all transitions
final class MainCoordinatorImpl: MainCoordinator {
    
    // MARK: - Public Properties
    
    public var navigationController: UINavigationController
    
    // MARK: - Private Properties
    
    private var screenFactory: ScreenFactory
    
    // MARK: - Initializers
    
    init(
        navigationController: UINavigationController,
        assemblyBuilder: ScreenFactory = ScreenFactoryImpl()
    ) {
        self.navigationController = navigationController
        self.screenFactory = assemblyBuilder
    }
    
    // MARK: - Public Methods
    
    public func start() {
        let nc = navigationController
        let initialVC = screenFactory.createTeamScreen(coordinator: self)
        nc.viewControllers = [initialVC]
    }
    
    public func pushDetailedScreenWith(team: DetailedTeamScreenModelProtocol) {
        let detailedVC = screenFactory.createDetailedTeamScreen(coordinator: self, team: team)
        pushController(controller: detailedVC, animated: true)
    }
    
    func pushPlayerRosterScreenWith(
        players: TeamRoster,
        abbreviation: String
    ) {
        let playerRosterVC = screenFactory.createPlayerRosterScreen(
            coordinator: self,
            players: players,
            abbreviation: abbreviation
        )
        pushController(controller: playerRosterVC, animated: true)
    }
    
}
