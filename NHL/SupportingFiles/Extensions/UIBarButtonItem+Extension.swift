//
//  UIBarButtonItem+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 19.01.2022.
//

import UIKit

// MARK: - Create RightBarButtonItem

extension UIBarButtonItem {
    
    static func setupRightNavItem(
        _ target: Any,
        action: Selector,
        title: String? = nil,
        icon: UIImage? = nil,
        tintColor: UIColor? = .systemRed
    ) -> UIBarButtonItem {
        let rightBarButtonItem = UIBarButtonItem(
            image: icon,
            style: .plain,
            target: target,
            action: action
        )
        rightBarButtonItem.tintColor = .systemOrange
        rightBarButtonItem.title = title
        rightBarButtonItem.tintColor = tintColor
        return rightBarButtonItem
    }
    
}
