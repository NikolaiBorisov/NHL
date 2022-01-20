//
//  PlayerRosterScreenModelProtocol.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Protocol contains properties for PlayerRosterViewController
protocol PlayerRosterScreenModelProtocol {
    var person: Person { get }
    var jerseyNumber: String? { get }
    var id: Int { get }
    var positionStr: String { get }
}
