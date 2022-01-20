//
//  UIImageView+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 31.12.2021.
//

import UIKit
import SDWebImage

// MARK: - Download and Set an Image Using SDWebImage

extension UIImageView {
    
    func setupImage(with url: String, for view: UIImageView, completion: @escaping () -> Void) {
        guard let url = URL(string: url) else { return }
        view.sd_setImage(with: url, completed: nil)
        completion()
    }
    
}
