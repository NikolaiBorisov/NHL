//
//  GameDTO.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

// MARK: - Prefixes for Host and Guest Cell

enum StatsPrefix: String {
    case goals = "Goals:\n"
    case pims = "Penalty Minutes:\n"
    case shots = "Shots:\n"
    case powerPlayPercentage = "Power Play %:\n"
    case powerPlayGoals = "Power Play Goals:\n"
    case powerPlayOpportunities = "Power Play Opportunities:\n"
    case faceOffWinPercentage = "Face Off Win %:\n"
    case blocks = "Blocked:\n"
    case takeaways = "Takeaways:\n"
    case giveaways = "Giveaways:\n"
    case hits = "Hits:\n"
}

// MARK: - GameDTO

struct GameDTO: Codable {
    let copyright: String?
    let teams: Teams
    let officials: [OfficialElement]
}

// MARK: - OfficialElement

struct OfficialElement: Codable {
    let official: Official?
    let officialType: String?
}

// MARK: - Official

struct Official: Codable {
    let id: Int?
    let fullName, link: String?
}

// MARK: - Teams

struct Teams: Codable {
    let away: Away
    let home: Home
}

// MARK: - Away

struct Away: Codable {
    let team: TeamData
    let teamStats: TeamStats
    let players: AwayPlayers
    let goalies, skaters, onIce: [Int]
    let onIcePlus: [OnIcePlus]
    let scratches: [Int]
    let penaltyBox: [JSONAny]
    let coaches: [Coach]
}

// MARK: - Coach

struct Coach: Codable {
    let person: CoachPerson
    let position: PositionData
}

// MARK: - CoachPerson

struct CoachPerson: Codable {
    let fullName, link: String
}

// MARK: - PositionData

struct PositionData: Codable {
    let code: PositionCode
    let name, type: PositionTypeEnum
    let abbreviation: Abbreviation
}

enum Abbreviation: String, Codable {
    case c = "C"
    case d = "D"
    case g = "G"
    case headCoach = "Head Coach"
    case lw = "LW"
    case nA = "N/A"
    case rw = "RW"
}

enum PositionCode: String, Codable {
    case c = "C"
    case d = "D"
    case g = "G"
    case hc = "HC"
    case l = "L"
    case nA = "N/A"
    case r = "R"
}

enum PositionTypeEnum: String, Codable {
    case center = "Center"
    case defenseman = "Defenseman"
    case forward = "Forward"
    case goalie = "Goalie"
    case headCoach = "Head Coach"
    case leftWing = "Left Wing"
    case rightWing = "Right Wing"
    case unknown = "Unknown"
}

// MARK: - OnIcePlus

struct OnIcePlus: Codable {
    let playerID, shiftDuration, stamina: Int
    
    enum CodingKeys: String, CodingKey {
        case playerID = "playerId"
        case shiftDuration, stamina
    }
}

// MARK: - AwayPlayers

struct AwayPlayers: Codable {
    let id8474709, id8477939: ID8466139Class?
    let id8468575: ID8468575Class?
    let id8468493, id8474037: ID8466139Class?
    let id8475716: ID8468575Class?
    let id8476941, id8475786, id8470611, id8476853: ID8466139Class?
    let id8479318, id8479458, id8477015: ID8466139Class?
    let id8476410: ID8468575Class?
    let id8475883: Id847?
    let id8473463, id8475098, id8474581, id8478483: ID8466139Class?
    let id8475172, id8480158, id8466139: ID8466139Class?
    
    enum CodingKeys: String, CodingKey {
        case id8474709 = "ID8474709"
        case id8477939 = "ID8477939"
        case id8468575 = "ID8468575"
        case id8468493 = "ID8468493"
        case id8474037 = "ID8474037"
        case id8475716 = "ID8475716"
        case id8476941 = "ID8476941"
        case id8475786 = "ID8475786"
        case id8470611 = "ID8470611"
        case id8476853 = "ID8476853"
        case id8479318 = "ID8479318"
        case id8479458 = "ID8479458"
        case id8477015 = "ID8477015"
        case id8476410 = "ID8476410"
        case id8475883 = "ID8475883"
        case id8473463 = "ID8473463"
        case id8475098 = "ID8475098"
        case id8474581 = "ID8474581"
        case id8478483 = "ID8478483"
        case id8475172 = "ID8475172"
        case id8480158 = "ID8480158"
        case id8466139 = "ID8466139"
    }
}

// MARK: - ID8466139Class

struct ID8466139Class: Codable {
    let person: ID8466139Person
    let jerseyNumber: String
    let position: PositionData
    let stats: ID8466139Stats
}

// MARK: - ID8466139Person

struct ID8466139Person: Codable {
    let id: Int
    let fullName, link, firstName, lastName: String
    let primaryNumber, birthDate: String
    let currentAge: Int
    let birthCity: String
    let birthStateProvince: String?
    let birthCountry, nationality, height: String
    let weight: Int
    let active, alternateCaptain, captain, rookie: Bool
    let shootsCatches: PositionCode
    let rosterStatus: RosterStatus
    let currentTeam: TeamData
    let primaryPosition: PositionData
}

// MARK: - TeamData

struct TeamData: Codable {
    let id: Int
    let name: TeamName
    let link: Link
}

enum Link: String, Codable {
    case apiV1Teams1 = "/api/v1/teams/1"
    case apiV1Teams2 = "/api/v1/teams/2"
    case apiV1Teams3 = "/api/v1/teams/3"
    case apiV1Teams4 = "/api/v1/teams/4"
    case apiV1Teams5 = "/api/v1/teams/5"
    case apiV1Teams6 = "/api/v1/teams/6"
    case apiV1Teams7 = "/api/v1/teams/7"
    case apiV1Teams8 = "/api/v1/teams/8"
    case apiV1Teams9 = "/api/v1/teams/9"
    case apiV1Teams10 = "/api/v1/teams/10"
    // case apiV1Teams11 = "/api/v1/teams/11"
    case apiV1Teams12 = "/api/v1/teams/12"
    case apiV1Teams13 = "/api/v1/teams/13"
    case apiV1Teams14 = "/api/v1/teams/14"
    case apiV1Teams15 = "/api/v1/teams/15"
    case apiV1Teams16 = "/api/v1/teams/16"
    case apiV1Teams17 = "/api/v1/teams/17"
    case apiV1Teams18 = "/api/v1/teams/18"
    case apiV1Teams19 = "/api/v1/teams/19"
    case apiV1Teams20 = "/api/v1/teams/20"
    case apiV1Teams21 = "/api/v1/teams/21"
    case apiV1Teams22 = "/api/v1/teams/22"
    case apiV1Teams23 = "/api/v1/teams/23"
    case apiV1Teams24 = "/api/v1/teams/24"
    case apiV1Teams25 = "/api/v1/teams/25"
    case apiV1Teams26 = "/api/v1/teams/26"
    case apiV1Teams27 = "/api/v1/teams/27"
    case apiV1Teams28 = "/api/v1/teams/28"
    case apiV1Teams29 = "/api/v1/teams/29"
    case apiV1Teams30 = "/api/v1/teams/30"
    
    case apiV1Teams52 = "/api/v1/teams/52"
    case apiV1Teams53 = "/api/v1/teams/53"
    case apiV1Teams54 = "/api/v1/teams/54"
    case apiV1Teams55 = "/api/v1/teams/55"
}

enum TeamName: String, Codable {
    case newJerseyDevils = "New Jersey Devils"
    case newYorkIslanders = "New York Islanders"
    case newYorkRangers = "New York Rangers"
    case philadelphiaFlyers = "Philadelphia Flyers"
    case pittsburghPenguins = "Pittsburgh Penguins"
    case bostonBruins = "Boston Bruins"
    case buffaloSabres = "Buffalo Sabres"
    case montréalCanadiens = "Montréal Canadiens"
    case ottawaSenators = "Ottawa Senators"
    case torontoMapleLeafs = "Toronto Maple Leafs"
    case carolinaHurricanes = "Carolina Hurricanes"
    case floridaPanthers = "Florida Panthers"
    case tampaBayLightning = "Tampa Bay Lightning"
    case washingtonCapitals = "Washington Capitals"
    case chicagoBlackhawks = "Chicago Blackhawks"
    case detroitRedWings = "Detroit Red Wings"
    case nashvillePredators = "Nashville Predators"
    case stLouisBlues = "St. Louis Blues"
    case calgaryFlames = "Calgary Flames"
    case coloradoAvalanche = "Colorado Avalanche"
    case edmontonOilers = "Edmonton Oilers"
    case vancouverCanucks = "Vancouver Canucks"
    case anaheimDucks = "Anaheim Ducks"
    case dallasStars = "Dallas Stars"
    case losAngelesKings = "Los Angeles Kings"
    case sanJoseSharks = "San Jose Sharks"
    case columbusBlueJackets = "Columbus Blue Jackets"
    case minnesotaWild = "Minnesota Wild"
    case winnipegJets = "Winnipeg Jets"
    case arizonaCoyotes = "Arizona Coyotes"
    case vegasGoldenKnights = "Vegas Golden Knights"
    case seattleKraken = "Seattle Kraken"
}

enum RosterStatus: String, Codable {
    case n = "N"
    case y = "Y"
}

// MARK: - ID8466139Stats

struct ID8466139Stats: Codable {
    let skaterStats: SkaterStats
}

// MARK: - SkaterStats

struct SkaterStats: Codable {
    let timeOnIce: String
    let assists, goals, shots, hits: Int
    let powerPlayGoals, powerPlayAssists, penaltyMinutes: Int
    let faceOffPct: Double?
    let faceOffWINS, faceoffTaken, takeaways, giveaways: Int
    let shortHandedGoals, shortHandedAssists, blocked, plusMinus: Int
    let evenTimeOnIce, powerPlayTimeOnIce, shortHandedTimeOnIce: String
    
    enum CodingKeys: String, CodingKey {
        case timeOnIce, assists, goals, shots, hits, powerPlayGoals, powerPlayAssists, penaltyMinutes, faceOffPct
        case faceOffWINS = "faceOffWins"
        case faceoffTaken, takeaways, giveaways, shortHandedGoals, shortHandedAssists, blocked, plusMinus, evenTimeOnIce, powerPlayTimeOnIce, shortHandedTimeOnIce
    }
}

// MARK: - ID8468575Class

struct ID8468575Class: Codable {
    let person: ID8466139Person
    let jerseyNumber: String
    let position: PositionData
    let stats: ID8468575Stats
}

// MARK: - ID8468575Stats

struct ID8468575Stats: Codable {
}

// MARK: - Id847

struct Id847: Codable {
    let person: ID8466139Person
    let jerseyNumber: String
    let position: PositionData
    let stats: ID8475883Stats
}

// MARK: - ID8475883Stats

struct ID8475883Stats: Codable {
    let goalieStats: GoalieStats
}

// MARK: - GoalieStats

struct GoalieStats: Codable {
    let timeOnIce: String
    let assists, goals, pim, shots: Int
    let saves, powerPlaySaves, shortHandedSaves, evenSaves: Int
    let shortHandedShotsAgainst, evenShotsAgainst, powerPlayShotsAgainst: Int
    let decision: String
    let savePercentage, powerPlaySavePercentage: Double
    let shortHandedSavePercentage: Int?
    let evenStrengthSavePercentage: Double
}

// MARK: - TeamStats

struct TeamStats: Codable {
    let teamSkaterStats: TeamSkaterStats
}

// MARK: - TeamSkaterStats

struct TeamSkaterStats: Codable {
    let goals, pim, shots: Int
    let powerPlayPercentage: String
    let powerPlayGoals, powerPlayOpportunities: Int
    let faceOffWinPercentage: String
    let blocked, takeaways, giveaways, hits: Int
}

// MARK: - Home

struct Home: Codable {
    let team: TeamData
    let teamStats: TeamStats
    let players: HomePlayers
    let goalies, skaters, onIce: [Int]
    let onIcePlus: [OnIcePlus]
    let scratches: [Int]
    let penaltyBox: [JSONAny]
    let coaches: [Coach]
}

// MARK: - HomePlayers

struct HomePlayers: Codable {
    let id8473618, id8471218, id8470834, id8470828: ID8466139Class?
    let id8476945: Id847?
    let id8477429, id8473412, id8477448, id8476469: ID8466139Class?
    let id8477359: ID8468575Class?
    let id8479339, id8477504, id8475179, id8474574: ID8466139Class?
    let id8476885, id8477940: ID8466139Class?
    let id8475279: ID8468575Class?
    let id8473574, id8476460: ID8466139Class?
    let id8477464: ID8468575Class?
    let id8473461: Id847?
    let id8476392, id8479293: ID8466139Class?
    
    enum CodingKeys: String, CodingKey {
        case id8473618 = "ID8473618"
        case id8471218 = "ID8471218"
        case id8470834 = "ID8470834"
        case id8470828 = "ID8470828"
        case id8476945 = "ID8476945"
        case id8477429 = "ID8477429"
        case id8473412 = "ID8473412"
        case id8477448 = "ID8477448"
        case id8476469 = "ID8476469"
        case id8477359 = "ID8477359"
        case id8479339 = "ID8479339"
        case id8477504 = "ID8477504"
        case id8475179 = "ID8475179"
        case id8474574 = "ID8474574"
        case id8476885 = "ID8476885"
        case id8477940 = "ID8477940"
        case id8475279 = "ID8475279"
        case id8473574 = "ID8473574"
        case id8476460 = "ID8476460"
        case id8477464 = "ID8477464"
        case id8473461 = "ID8473461"
        case id8476392 = "ID8476392"
        case id8479293 = "ID8479293"
    }
}

// MARK: - Encode/Decode Helpers

final class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

final class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

final class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

// MARK: - GameViewModelProtocol

extension GameDTO: GameViewModelProtocol {
    var imageHost: UIImage? { UIImage(named: "\(teams.home.team.id)") }
    var imageGuest: UIImage? { UIImage(named: "\(teams.away.team.id)") }
    var teamHostName: String { teams.home.team.name.rawValue }
    var scoreHost: String { "\(teams.home.teamStats.teamSkaterStats.goals)" }
    var teamGuestName: String { teams.away.team.name.rawValue }
    var scoreGuest: String { "\(teams.away.teamStats.teamSkaterStats.goals)" }
}

// MARK: - HostStatsCellModelProtocol

extension GameDTO: HostStatsCellModelProtocol {
    var goalsH: String { "\(teams.home.teamStats.teamSkaterStats.goals)" }
    var pimsH: String { "\(teams.home.teamStats.teamSkaterStats.pim)" }
    var shotsH: String { "\(teams.home.teamStats.teamSkaterStats.shots)" }
    var powerPlayPercentageH: String { teams.home.teamStats.teamSkaterStats.powerPlayPercentage }
    var powerPlayGoalsH: String { "\(teams.home.teamStats.teamSkaterStats.powerPlayGoals)" }
    var powerPlayOpportunitiesH: String { "\(teams.home.teamStats.teamSkaterStats.powerPlayOpportunities)" }
    var faceOffWinPercentageH: String { teams.home.teamStats.teamSkaterStats.faceOffWinPercentage }
    var blocksH: String { "\(teams.home.teamStats.teamSkaterStats.blocked)" }
    var takeawaysH: String { "\(teams.home.teamStats.teamSkaterStats.takeaways)" }
    var giveawaysH: String { "\(teams.home.teamStats.teamSkaterStats.giveaways)" }
    var hitsH: String { "\(teams.home.teamStats.teamSkaterStats.hits)" }
}

// MARK: - GuestStatsCellModelProtocol

extension GameDTO: GuestStatsCellModelProtocol {
    var goalsG: String { "\(teams.away.teamStats.teamSkaterStats.goals)" }
    var pimsG: String { "\(teams.away.teamStats.teamSkaterStats.pim)" }
    var shotsG: String { "\(teams.away.teamStats.teamSkaterStats.shots)" }
    var powerPlayPercentageG: String { teams.away.teamStats.teamSkaterStats.powerPlayPercentage }
    var powerPlayGoalsG: String { "\(teams.away.teamStats.teamSkaterStats.powerPlayGoals)" }
    var powerPlayOpportunitiesG: String { "\(teams.away.teamStats.teamSkaterStats.powerPlayOpportunities)" }
    var faceOffWinPercentageG: String { teams.away.teamStats.teamSkaterStats.faceOffWinPercentage }
    var blocksG: String { "\(teams.away.teamStats.teamSkaterStats.blocked)" }
    var takeawaysG: String { "\(teams.away.teamStats.teamSkaterStats.takeaways)" }
    var giveawaysG: String { "\(teams.away.teamStats.teamSkaterStats.giveaways)" }
    var hitsG: String { "\(teams.away.teamStats.teamSkaterStats.hits)" }
}
