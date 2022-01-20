//
//  PlayerDTO.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import Foundation

// MARK: - PlayerDTO

struct PlayerDTO: Codable {
    let copyright: String
    let people: [DetailedPlayer]
}

// MARK: - DetailedPlayer

struct DetailedPlayer: Codable {
    let id: Int
    let fullName, link, firstName, lastName: String
    let primaryNumber, birthDate: String
    let currentAge: Int
    let birthCity: String
    var birthStateProvince: String? = "-"
    let birthCountry: String
    let nationality: String
    let height: String
    let weight: Int
    let active, alternateCaptain, captain, rookie: Bool
    let shootsCatches, rosterStatus: String
    let currentTeam: CurrentTeam
    let primaryPosition: PrimaryPosition
}

// MARK: - CurrentTeam

struct CurrentTeam: Codable {
    let id: Int
    let name, link: String
}

// MARK: - PrimaryPosition

struct PrimaryPosition: Codable {
    let code, name, type, abbreviation: String
}

// MARK: - DetailedPlayerScreenModelProtocol

extension DetailedPlayer: DetailedPlayerScreenModelProtocol {}
