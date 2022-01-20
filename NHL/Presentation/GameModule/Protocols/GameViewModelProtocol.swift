//
//  GameViewModelProtocol.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 14.01.2022.
//

import UIKit

/// Protocol contains properties for GameView
protocol GameViewModelProtocol {
    var imageHost: UIImage? { get }
    var imageGuest: UIImage? { get }
    var teamHostName: String { get }
    var teamGuestName: String { get }
    var scoreHost: String { get }
    var scoreGuest: String { get }
}
