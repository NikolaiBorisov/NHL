//
//  GamePresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

/// Class contains methods for GamePresenterOutputDelegate
protocol GamePresenterOutputDelegate: AnyObject {
    var delegate: GamePresenterInputDelegate? { get set }
    func showAlert()
    func getData(with id: Int, completion: @escaping (GameDTO) -> Void)
}
