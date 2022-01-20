//
//  GamePresenterInputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

/// Class contains methods for GamePresenterInputDelegate
protocol GamePresenterInputDelegate: AnyObject {
    func startAnimating()
    func stopAnimating()
    func endRefreshing()
    func showGameIDAlert()
    func showFailureAlert(with error: Error)
    func reloadView(_ gameData: GameDTO)
}
