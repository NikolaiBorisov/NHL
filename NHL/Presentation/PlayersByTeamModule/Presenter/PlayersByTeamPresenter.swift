//
//  PlayersByTeamPresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 06.01.2022.
//

import UIKit

/// Class provides presenter for PlayersByTeamViewController
final class PlayersByTeamPresenter {
    
    // MARK: - Public Properties
    
    public var delegate: PlayersByTeamPresenterInputDelegate?
    
    // MARK: - Private Properties
    
    private let afDataFetcherService = AFDataFetcherService()
    
    // MARK: - Initializers
    
    init(delegate: PlayersByTeamPresenterInputDelegate) {
        self.delegate = delegate
    }
    
}

// MARK: - PlayersByTeamPresenterOutputDelegate

extension PlayersByTeamPresenter: PlayersByTeamPresenterOutputDelegate {
    
    // MARK: - Public Methods
    
    public func getData() {
        delegate?.startAnimating()
        afDataFetcherService.fetchTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.delegate?.presentErrorAlertWith(title: "Oops!", message: error as! AppError)
                print(error)
            case .success(let data):
                guard let data = data else { return }
                self.delegate?.reloadView(data)
                self.delegate?.stopAnimating()
            }
        }
    }
    
    public func didTapOn(team: Team) {
        delegate?.showNextVCWith(team: team)
    }
    
}
