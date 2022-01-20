//
//  DetailedPlayerPresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

/// Protocol contains methods for DetailedPlayerPresenterOutputDelegate
protocol DetailedPlayerPresenterOutputDelegate: AnyObject {
    var delegate: DetailedPlayerPresenterInputDelegate? { get set }
    func getData(for id: Int)
}
