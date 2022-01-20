//
//  UIView+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

// MARK: - CellIdentifier

/// Uses class name for cellIdentifier. Returns class name. Use it for Register cells
extension UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

// MARK: - RoundView

extension UIView {
    
    func roundViewWith(cornerRadius: CGFloat = 0, borderColor: UIColor? = nil, borderWidth: CGFloat = 0) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
    }
    
}
