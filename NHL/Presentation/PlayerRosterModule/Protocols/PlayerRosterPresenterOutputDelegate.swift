//
//  PlayerRosterPresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Protocol contains properties and methods for PlayerRosterPresenterOutputDelegate
protocol PlayerRosterPresenterOutputDelegate: AnyObject {
    var delegate: PlayerRosterPresenterInputDelegate? { get set }
    func didTapOn(player: RosterElement)
}
