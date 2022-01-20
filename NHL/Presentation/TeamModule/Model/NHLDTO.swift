//
//  NHLDTO.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

// MARK: - NHLDTO

struct NHLDTO: Codable {
    let copyright: String
    let teams: [Team]
    
//    init(json: JSON) {
//        copyright = json["copyright"].stringValue
//        teams = json["teams"].arrayObject as? [Team] ?? []
//    }
}

// MARK: - Team

struct Team: Codable {
    let id: Int
    let name, link: String
    let venue: Venue
    let abbreviation, teamName, locationName, firstYearOfPlay: String
    let division: Division
    let conference: Conference
    let franchise: Franchise
    let roster: TeamRoster
    let shortName: String
    let officialSiteURL: String
    let franchiseID: Int
    let active: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, venue, abbreviation, teamName, locationName, firstYearOfPlay, division, conference, franchise, roster, shortName
        case officialSiteURL = "officialSiteUrl"
        case franchiseID = "franchiseId"
        case active
    }
}

// MARK: - Conference

struct Conference: Codable {
    let id: Int
    let name: ConferenceName
    let link: ConferenceLink
}

enum ConferenceLink: String, Codable {
    case apiV1Conferences5 = "/api/v1/conferences/5"
    case apiV1Conferences6 = "/api/v1/conferences/6"
}

enum ConferenceName: String, Codable {
    case eastern = "Eastern"
    case western = "Western"
}

// MARK: - Division

struct Division: Codable {
    let id: Int
    let name: DivisionName
    let nameShort: NameShort
    let link: DivisionLink
    let abbreviation: DivisionAbbreviation
}

enum DivisionAbbreviation: String, Codable {
    case a = "A"
    case c = "C"
    case m = "M"
    case p = "P"
}

enum DivisionLink: String, Codable {
    case apiV1Divisions15 = "/api/v1/divisions/15"
    case apiV1Divisions16 = "/api/v1/divisions/16"
    case apiV1Divisions17 = "/api/v1/divisions/17"
    case apiV1Divisions18 = "/api/v1/divisions/18"
}

enum DivisionName: String, Codable {
    case atlantic = "Atlantic"
    case central = "Central"
    case metropolitan = "Metropolitan"
    case pacific = "Pacific"
}

enum NameShort: String, Codable {
    case atl = "ATL"
    case cen = "CEN"
    case metro = "Metro"
    case pac = "PAC"
}

// MARK: - Franchise

struct Franchise: Codable {
    let franchiseID: Int
    let teamName, link: String
    
    enum CodingKeys: String, CodingKey {
        case franchiseID = "franchiseId"
        case teamName, link
    }
}

// MARK: - TeamRoster

struct TeamRoster: Codable {
    let roster: [RosterElement]
    let link: String
}

// MARK: - RosterElement

struct RosterElement: Codable {
    let person: Person
    let jerseyNumber: String?
    let position: Position
}

// MARK: - Person

struct Person: Codable {
    let id: Int
    let fullName, link: String
}

// MARK: - Position

struct Position: Codable {
    let code: Code
    let name: PositionName
    let type: TypeEnum
    let abbreviation: PositionAbbreviation
}

enum PositionAbbreviation: String, Codable {
    case c = "C"
    case d = "D"
    case g = "G"
    case lw = "LW"
    case rw = "RW"
}

enum Code: String, Codable {
    case c = "C"
    case d = "D"
    case g = "G"
    case l = "L"
    case r = "R"
}

enum PositionName: String, Codable {
    case center = "Center"
    case defenseman = "Defenseman"
    case goalie = "Goalie"
    case leftWing = "Left Wing"
    case rightWing = "Right Wing"
}

enum TypeEnum: String, Codable {
    case defenseman = "Defenseman"
    case forward = "Forward"
    case goalie = "Goalie"
}

// MARK: - Venue

struct Venue: Codable {
    let name, link, city: String
    let timeZone: TimeZone
    let id: Int?
}

// MARK: - TimeZone

struct TimeZone: Codable {
    let id: String
    let offset: Int
    let tz: Tz
}

enum Tz: String, Codable {
    case cst = "CST"
    case est = "EST"
    case mst = "MST"
    case pst = "PST"
}

// MARK: - DetailedTeamScreenModelProtocol, TeamScreenModelProtocol

extension Team:
    DetailedTeamScreenModelProtocol,
    TeamScreenModelProtocol,
    PlayersByTeamScreenModelProtocol
{
    var image: UIImage? { UIImage(named: "\(id)") }
    var city: String { venue.city }
    var timeZone: String { venue.timeZone.tz.rawValue }
    var divisionStr: String { division.name.rawValue }
    var conferenceStr: String { conference.name.rawValue }
    var venueStr: String { venue.name }
    var totalPlayers: String { "\(roster.roster.count)" }
    var imgPlayer: UIImage { AppImage.imgPlaceholder }
    var numberOfRows: Int { 10 }
}

// MARK: - PlayerRosterScreenModelProtocol

extension RosterElement: PlayerRosterScreenModelProtocol {
    var positionStr: String { position.name.rawValue }
    var id: Int { person.id }
}
