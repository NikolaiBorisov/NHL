//
//  PlayersByTeamPresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 06.01.2022.
//

import UIKit

/// Protocol contains properties and methods for PlayersByTeamPresenterOutputDelegate
protocol PlayersByTeamPresenterOutputDelegate: AnyObject {
    var delegate: PlayersByTeamPresenterInputDelegate? { get set }
    func getData()
    func didTapOn(team: Team)
}

