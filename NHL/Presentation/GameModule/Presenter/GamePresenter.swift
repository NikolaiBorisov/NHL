//
//  GamePresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

/// Class provides presenter for GameViewController
final class GamePresenter {
    
    // MARK: - Public Properties
    
    public weak var delegate: GamePresenterInputDelegate?
    
    // MARK: - Private Properties
    
    private var dataFetcherService = AFDataFetcherService()
    
    // MARK: - Initializers
    
    init(delegate: GamePresenterInputDelegate) {
        self.delegate = delegate
    }
}

// MARK: - GamePresenterOutputDelegate

extension GamePresenter: GamePresenterOutputDelegate {
    
    func getData(with id: Int, completion: @escaping (GameDTO) -> Void) {
        delegate?.startAnimating()
        self.dataFetcherService.fetchGameInfo(for: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.delegate?.showFailureAlert(with: error)
                print(error)
            case .success(let data):
                guard let gameData = data else { return }
                completion(gameData)
                self.delegate?.reloadView(gameData)
                self.delegate?.stopAnimating()
                self.delegate?.endRefreshing()
            }
        }
    }
    
    func showAlert() {
        delegate?.showGameIDAlert()
    }
    
}
