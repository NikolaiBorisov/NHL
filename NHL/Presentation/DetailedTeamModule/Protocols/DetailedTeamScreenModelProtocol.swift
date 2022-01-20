//
//  DetailedTeamScreenModelProtocol.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 06.01.2022.
//

import UIKit

/// Protocol contains properties for DetailedTeamViewController
protocol DetailedTeamScreenModelProtocol {
    var image: UIImage? { get }
    var name: String { get }
    var teamName: String { get }
    var city: String { get }
    var timeZone: String { get }
    var abbreviation: String { get }
    var firstYearOfPlay: String { get }
    var divisionStr: String { get }
    var conferenceStr: String { get }
    var venueStr: String { get }
    var officialSiteURL: String { get }
    var numberOfRows: Int { get }
}
