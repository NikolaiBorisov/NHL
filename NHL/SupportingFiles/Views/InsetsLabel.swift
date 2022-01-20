//
//  InsetsLabel.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 12.01.2022.
//

import UIKit

final class InsetsLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10))
        )
    }
    
}
