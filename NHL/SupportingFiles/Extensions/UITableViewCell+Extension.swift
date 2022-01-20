//
//  UITableViewCell+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 04.01.2022.
//

import UIKit

// MARK: - AnimateCell

extension UITableViewCell {
    
    func animateCell(at indexPath: IndexPath) {
        self.alpha = 0
        UIView.animate(
            withDuration: 0.3,
            delay: 0.03 * Double(indexPath.row)
        ) {
            self.alpha = 1
        }
    }
    
}

// MARK: - AccessoryView

extension UITableViewCell {
    
    func createAccessoryView(with color: UIColor, image: UIImage) -> UIImageView {
        let image = image
        let accessoryImage = UIImageView(frame:CGRect(
            x: 0,
            y: 0,
            width: 20,
            height: 20)
        )
        accessoryImage.image = image
        accessoryImage.tintColor = color
        return accessoryImage
    }
    
}
