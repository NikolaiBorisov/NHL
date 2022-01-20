//
//  DetailedTeamPresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 31.12.2021.
//

import UIKit

/// Protocol contains properties and methods for DetailedTeamPresenterOutputDelegate
protocol DetailedTeamPresenterOutputDelegate: AnyObject {
    var delegate: DetailedTeamPresenterInputDelegate? { get set }
    func openSiteWith(url: String)
}
