//
//  GameViewController+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 18.01.2022.
//

import UIKit

// MARK: - HeaderView

extension GameViewController {
    
    func createHeaderView(for view: UIView, with text: String, color: UIColor) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(
            view: view,
            withText: text,
            color: color
        )
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}
