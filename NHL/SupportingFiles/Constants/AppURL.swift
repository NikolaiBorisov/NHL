//
//  AppURL.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

enum AppURL {
    static let teamURL = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.roster"
    
    static let teamLogoURL = { (id: Int) in
    "https://www-league.nhlstatic.com/images/logos/teams-current-primary-light/\(id).svg"
    }
    
    static let playerURL = "https://statsapi.web.nhl.com/api/v1/teams?expand=team.roster"
    
    static let playerImageURL = { (id: Int) in
        "http://nhl.bamcontent.com/images/headshots/current/168x168/\(id).jpg"
    }
    
    static let detailedPlayerURL = { (id: Int) in
        "https://statsapi.web.nhl.com/api/v1/people/\(id)"
    }
    
    static let gameURL = { (id: Int) in
        "https://statsapi.web.nhl.com/api/v1/game/\(id)/boxscore"
    }
}
