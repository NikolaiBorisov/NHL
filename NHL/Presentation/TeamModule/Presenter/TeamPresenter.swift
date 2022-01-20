//
//  TeamPresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

/// Class provides Presenter for TeamViewController
final class TeamPresenter {
    
    // MARK: - Public Properties
    
    public weak var delegate: TeamPresenterInputDelegate?
    
    // MARK: - Private Properties
    
    private var coordinator: MainCoordinator?
    private let afDataFetcherService = AFDataFetcherService()
    
    // MARK: - Initializers
    
    init(
        delegate: TeamPresenterInputDelegate,
        coordinator: MainCoordinator
    ) {
        self.delegate = delegate
        self.coordinator = coordinator
    }
    
}

// MARK: - TeamPresenterOutputDelegate

extension TeamPresenter: TeamPresenterOutputDelegate {
    
    // MARK: - Public Methods
    
    public func getDataWithAF() {
        delegate?.startAnimating()
        afDataFetcherService.fetchTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teams):
                guard let teams = teams else { return }
                self.delegate?.reloadView(teams)
                self.delegate?.setupLabel(with: teams.copyright)
                self.delegate?.stopAnimating()
                self.delegate?.endRefreshing()
            case .failure(let error):
                self.delegate?.presentErrorAlertWith(title: "Oops!", message: error as! AppError)
                print(error)
            }
        }
    }
    
    public func didTapOn(team: DetailedTeamScreenModelProtocol) {
        delegate?.showNextVCWith(team: team)
    }
    
}
