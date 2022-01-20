//
//  PlayersByTeamPresenterInputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 06.01.2022.
//

import UIKit

/// Protocol contains methods for PlayersByTeamPresenterInputDelegate
protocol PlayersByTeamPresenterInputDelegate: AnyObject {
    func startAnimating()
    func stopAnimating()
    func reloadView(_ teams: NHLDTO)
    func presentErrorAlertWith(title: String, message: AppError)
    func showNextVCWith(team: Team)
}
