//
//  TeamPresenterInputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 31.12.2021.
//

import UIKit

/// Protocol contains methods for TeamPresenterInputDelegate
protocol TeamPresenterInputDelegate: AnyObject {
    func startAnimating()
    func stopAnimating()
    func reloadView(_ teams: NHLDTO)
    func endRefreshing()
    func presentErrorAlertWith(title: String, message: AppError)
    func showNextVCWith(team: DetailedTeamScreenModelProtocol)
    func setupLabel(with text: String)
}
