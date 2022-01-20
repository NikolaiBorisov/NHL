//
//  TeamPresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 31.12.2021.
//

import UIKit

/// Protocol contains properties and methods for TeamPresenterOutputDelegate
protocol TeamPresenterOutputDelegate: AnyObject {
    var delegate: TeamPresenterInputDelegate? { get set }
    func getDataWithAF()
    func didTapOn(team: DetailedTeamScreenModelProtocol)
}
