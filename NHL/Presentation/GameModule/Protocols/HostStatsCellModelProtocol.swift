//
//  HostStatsCellModelProtocol.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 14.01.2022.
//

import UIKit

/// Protocol contains properties for HostStatsCell
protocol HostStatsCellModelProtocol {
    var goalsH: String { get }
    var pimsH: String { get }
    var shotsH: String { get }
    var powerPlayPercentageH: String { get }
    var powerPlayGoalsH: String { get }
    var powerPlayOpportunitiesH: String { get }
    var faceOffWinPercentageH: String { get }
    var blocksH: String { get }
    var takeawaysH: String { get }
    var giveawaysH: String { get }
    var hitsH: String { get }
}
