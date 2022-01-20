//
//  ScreenFactory.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 30.12.2021.
//

import UIKit

protocol ScreenFactory {
    func createTeamScreen(coordinator: MainCoordinator) -> UIViewController
    func createPlayerByTeamScreen(coordinator: MainCoordinator) -> UIViewController
    func createGameScreen(coordinator: MainCoordinator) -> UIViewController
    
    func createPlayerRosterScreen(
        coordinator: MainCoordinator,
        players: TeamRoster,
        abbreviation: String
    ) -> UIViewController
    
    func createDetailedTeamScreen(
        coordinator: MainCoordinator,
        team: DetailedTeamScreenModelProtocol
    ) -> UIViewController
}

/// Class creates Screens
final class ScreenFactoryImpl: ScreenFactory {
    
    // MARK: - Public Methods
    
    public func createTeamScreen(coordinator: MainCoordinator) -> UIViewController {
        let vc = TeamViewController(coordinator: coordinator)
        let presenter = TeamPresenter(
            delegate: vc,
            coordinator: coordinator
        )
        vc.presenter = presenter
        return vc
    }
    
    public func createGameScreen(coordinator: MainCoordinator) -> UIViewController {
        let vc = GameViewController(coordinator: coordinator)
        // let presenter = GamePresenter(view: vc)
        // vc.presenter = presenter
        let nc = createNavController(for: vc, title: AppLabel.gameVC, image: AppImage.gameVC)
        return nc
    }
    
    public func createDetailedTeamScreen(
        coordinator: MainCoordinator,
        team: DetailedTeamScreenModelProtocol
    ) -> UIViewController {
        let vc = DetailedTeamViewController(coordinator: coordinator, team: team)
        let presenter = DetailedTeamPresenter(delegate: vc, coordinator: coordinator)
        vc.presenter = presenter
        return vc
    }
    
    public func createPlayerByTeamScreen(coordinator: MainCoordinator) -> UIViewController {
        let vc = PlayersByTeamViewController(coordinator: coordinator)
        let presenter = PlayersByTeamPresenter(delegate: vc)
        vc.presenter = presenter
        let nc = createNavController(for: vc, title: AppLabel.playerVC, image: AppImage.playerVC)
        return nc
    }
    
    public func createPlayerRosterScreen(
        coordinator: MainCoordinator,
        players: TeamRoster,
        abbreviation: String
    ) -> UIViewController {
        let vc = PlayerRosterViewController(
            coordinator: coordinator,
            players: players,
            abbreviation: abbreviation
        )
        let presenter = PlayerRosterPresenter(delegate: vc, coordinator: coordinator)
        vc.presenter = presenter
        return vc
    }
    
}
