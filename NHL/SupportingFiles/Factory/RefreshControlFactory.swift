//
//  RefreshControlFactory.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

/// Class creates refreshControl for UITableView and UICollectionView
final class RefreshControlFactory {
    static func generateWith( color: UIColor? = .cyan) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = color
        return refreshControl
    }
}
