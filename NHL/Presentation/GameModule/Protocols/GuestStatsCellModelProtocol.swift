//
//  GuestStatsCellModelProtocol.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 14.01.2022.
//

import UIKit

/// Protocol contains properties for GuestStatsCell
protocol GuestStatsCellModelProtocol {
    var goalsG: String { get }
    var pimsG: String { get }
    var shotsG: String { get }
    var powerPlayPercentageG: String { get }
    var powerPlayGoalsG: String { get }
    var powerPlayOpportunitiesG: String { get }
    var faceOffWinPercentageG: String { get }
    var blocksG: String { get }
    var takeawaysG: String { get }
    var giveawaysG: String { get }
    var hitsG: String { get }
}
