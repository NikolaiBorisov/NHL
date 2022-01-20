//
//  PlayersByTeamScreenModelProtocol.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 07.01.2022.
//

import UIKit

/// Protocol contains properties for PlayersByTeamViewController
protocol PlayersByTeamScreenModelProtocol {
    var name: String { get }
    var imgPlayer: UIImage { get }
    var totalPlayers: String { get }
}
