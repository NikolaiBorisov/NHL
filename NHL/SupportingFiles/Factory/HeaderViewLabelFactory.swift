//
//  HeaderViewLabelFactory.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import Foundation

import UIKit

/// Class creates headerLabel for UITableView
final class HeaderViewLabelFactory {
    
    static func generateLabelOn(
        view: UIView,
        withText: String,
        color: UIColor? = .cyan,
        font: UIFont? = .avenirNextDemiBoldOfSize(20)
    ) -> UILabel {
        let headerLabel = UILabel(frame: CGRect(x: 0, y: -5, width: view.frame.width, height: 30.0))
        headerLabel.text = withText
        headerLabel.textAlignment = .center
        headerLabel.textColor = color
        headerLabel.font = font
        return headerLabel
    }
    
}
