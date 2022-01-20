//
//  PlayerRosterPresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Class provides presenter for PlayerRosterViewController
final class PlayerRosterPresenter {
    
    // MARK: - Public Properties
    
    public var delegate: PlayerRosterPresenterInputDelegate?
    
    // MARK: - Private Properties
    
    private var coordinator: MainCoordinator?
    
    // MARK: - Initializers
    
    init(
        delegate: PlayerRosterPresenterInputDelegate,
        coordinator: MainCoordinator
    ) {
        self.delegate = delegate
        self.coordinator = coordinator
    }
    
}

// MARK: - PlayerRosterPresenterOutputDelegate

extension PlayerRosterPresenter: PlayerRosterPresenterOutputDelegate {
    
    func didTapOn(player: RosterElement) {
        delegate?.showNextVCWith(player: player)
    }
    
}
