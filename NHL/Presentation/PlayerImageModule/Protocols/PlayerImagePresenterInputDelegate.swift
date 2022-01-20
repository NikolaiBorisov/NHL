//
//  PlayerImagePresenterInputDelegate.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 18.01.2022.
//

import Foundation
import UIKit

protocol PlayerImagePresenterInputDelegate: AnyObject {
    func setupView()
    func animateView()
    func present(vc: UIActivityViewController)
}
