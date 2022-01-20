//
//  DetailedPlayerPresenterInputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

/// Protocol contains methods for DetailedPlayerPresenterInputDelegate
protocol DetailedPlayerPresenterInputDelegate: AnyObject {
    func startAnimating()
    func stopAnimating()
    func reloadView(_ player: PlayerDTO)
}
