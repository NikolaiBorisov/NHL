//
//  Favorite.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 19.01.2022.
//

import UIKit
import RealmSwift

class Favorite: Object {
    @objc dynamic var playerName: String = ""
    @objc dynamic var image: String = ""
}
