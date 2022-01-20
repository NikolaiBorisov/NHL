//
//  DetailedTeamPresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 30.12.2021.
//

import UIKit

/// Class provides Presenter for DetailedTeamViewController
final class DetailedTeamPresenter {
    
    // MARK: - Public Properties
    
    public weak var delegate: DetailedTeamPresenterInputDelegate?
    
    // MARK: - Private Properties
    
    private var coordinator: MainCoordinator?
    
    // MARK: - Initializers
    
    init(
        delegate: DetailedTeamPresenterInputDelegate,
        coordinator: MainCoordinator
    ) {
        self.delegate = delegate
        self.coordinator = coordinator
    }
    
    // MARK: - Public Methods
    
    public func openSiteWith(url: String) {
        let appShared = UIApplication.shared
        guard let url = URL(string: url), appShared.canOpenURL(url) else { return }
        appShared.open(url, options: [:], completionHandler: nil)
    }
    
}

// MARK: - DetailedTeamPresenterOutputDelegate

extension DetailedTeamPresenter: DetailedTeamPresenterOutputDelegate {}
