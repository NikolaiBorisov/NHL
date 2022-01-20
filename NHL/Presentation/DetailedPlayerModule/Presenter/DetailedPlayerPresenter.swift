//
//  DetailedPlayerPresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

/// Class provides presenter for DetailedPlayerViewController
final class DetailedPlayerPresenter {
    
    // MARK: - Public Properties
    
    public var delegate: DetailedPlayerPresenterInputDelegate?
    
    // MARK: - Private Properties
    
    private let afDataFetcherService = AFDataFetcherService()
    
    // MARK: - Initializers
    
    init(delegate: DetailedPlayerPresenterInputDelegate) {
        self.delegate = delegate
    }
    
}

// MARK: - DetailedPlayerPresenterOutputDelegate

extension DetailedPlayerPresenter: DetailedPlayerPresenterOutputDelegate {
    
    // MARK: - Public Methods
    
    public func getData(for id: Int) {
        delegate?.startAnimating()
        afDataFetcherService.fetchPlayerInfo(for: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                guard let data = data else { return }
                self.delegate?.reloadView(data)
                self.delegate?.stopAnimating()
            }
        }
    }
    
}
