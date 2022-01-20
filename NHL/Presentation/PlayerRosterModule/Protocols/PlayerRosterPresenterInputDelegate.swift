//
//  PlayerRosterPresenterInputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Protocol contains methods for PlayerRosterPresenterInputDelegate
protocol PlayerRosterPresenterInputDelegate: AnyObject {
    func showNextVCWith(player: RosterElement)
}
