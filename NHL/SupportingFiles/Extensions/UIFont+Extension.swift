//
//  UIFont+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

// MARK: - Returns Font of Needed Type and Size

extension UIFont {
    
    static var avenirNextMediumOfSize = { (size: CGFloat) in
        UIFont(name: AppFont.avenirNextMedium, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static var avenirNextDemiBoldOfSize = { (size: CGFloat) in
        UIFont(name: AppFont.avenirNextDemiBold, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static var avenirNextHeavyItalic = { (size: CGFloat) in
        UIFont(name: AppFont.avenirNextHeavyItalic, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
