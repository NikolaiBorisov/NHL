//
//  NSMutableAttributedString+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 04.01.2022.
//

import UIKit

// MARK: - Setup Needed Color, Font for NSMutableAttributedString

extension NSMutableAttributedString {
    
    // MARK: - Private Properties
    
    var nsAttKey: NSAttributedString.Key.Type { NSAttributedString.Key.self }
    
    // MARK: - Public Methods
    
    /// Set Specific Color for the Attributed Text
    func set(color: UIColor, for text: String) {
        let range = mutableString.range(of: text, options: .caseInsensitive)
        addAttribute(nsAttKey.foregroundColor, value: color, range: range)
    }
    
    /// Set Specific Font for the Attributed Text
    func set(font: UIFont, for text: String) {
        let range = mutableString.range(of: text, options: .caseInsensitive)
        addAttribute(nsAttKey.font, value: font, range: range)
    }
    
    /// Underline Specific Attributed Text
    func underlineWith(alpha: CGFloat, color: UIColor, for text: String) {
        let range = mutableString.range(of: text, options: .caseInsensitive)
        addAttribute(nsAttKey.underlineColor, value: color.withAlphaComponent(alpha), range: range)
        addAttribute(nsAttKey.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
    }
    
}
