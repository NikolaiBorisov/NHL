//
//  PlayerImagePresenter.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 18.01.2022.
//

import UIKit

/// Class provides presenter for PlayerImageViewController
final class PlayerImagePresenter {
    
    // MARK: - Public Properties
    
    public var delegate: PlayerImagePresenterInputDelegate?
    
    // MARK: - Private Properties
    
    // MARK: - Initializers
    
    init(delegate: PlayerImagePresenterInputDelegate) {
        self.delegate = delegate
    }
    
}

// MARK: - PlayerImagePresenterOutputDelegate

extension PlayerImagePresenter: PlayerImagePresenterOutputDelegate {
    
    func createActivityViewController(with item: Any) {
        let shareController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        delegate?.present(vc: shareController)
    }
    
    func setupImage() {
        delegate?.animateView()
        delegate?.setupView()
    }
    
}
