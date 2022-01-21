//
//  FavoritesPresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 21.01.2022.
//

import UIKit

/// Class provides presenter for FavoritesViewController
final class FavoritesPresenter {
    
    // MARK: - Public Properties
    
    public var delegate: FavoritesPresenterInputDelegate
    
    // MARK: - Initializers
    
    init(delegate: FavoritesPresenterInputDelegate) {
        self.delegate = delegate
    }
    
}

// MARK: - PlayerImagePresenterOutputDelegate

extension FavoritesPresenter: FavoritesPresenterOutputDelegate {
    
    func getData() { delegate.fetchDataFromRealm() }
    
}
