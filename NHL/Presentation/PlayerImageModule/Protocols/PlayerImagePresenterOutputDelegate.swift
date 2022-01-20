//
//  PlayerImagePresenterOutputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 18.01.2022.
//

import Foundation

protocol PlayerImagePresenterOutputDelegate: AnyObject {
    var delegate: PlayerImagePresenterInputDelegate? { get set }
    func setupImage()
    func createActivityViewController(with item: Any)
}
