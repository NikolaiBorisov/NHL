//
//  PlayerRosterView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Class contains UIElements for PlayerRosterViewController
final class PlayerRosterView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var playerRosterTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: PlayerRosterCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        $0.showsVerticalScrollIndicator = true
        return $0
    }(UITableView())
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .black
    }
    
    private func addSubviews() {
        addSubview(playerRosterTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            playerRosterTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            playerRosterTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerRosterTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerRosterTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
