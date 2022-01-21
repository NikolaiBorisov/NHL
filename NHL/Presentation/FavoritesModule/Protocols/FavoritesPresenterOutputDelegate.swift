//
//  FavoritesPresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 21.01.2022.
//

import Foundation

protocol FavoritesPresenterOutputDelegate {
    var delegate: FavoritesPresenterInputDelegate { get set }
    func getData()
}
