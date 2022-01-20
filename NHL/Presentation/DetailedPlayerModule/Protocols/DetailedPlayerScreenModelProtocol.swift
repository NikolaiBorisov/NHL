//
//  DetailedPlayerScreenModelProtocol.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Protocol contains properties for DetailedPlayerScreenModelProtocol
protocol DetailedPlayerScreenModelProtocol {
    var firstName: String { get }
    var lastName: String { get }
    var primaryNumber: String { get }
    var birthDate: String { get }
    var currentAge: Int { get }
    var birthCity: String { get }
    var birthCountry: String { get }
    var nationality: String { get }
    var height: String { get }
    var weight: Int { get }
    var primaryPosition: PrimaryPosition { get }
}

