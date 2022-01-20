//
//  PlayersByTeamView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 06.01.2022.
//

import UIKit

/// Class contains UIElements and methods for PlayersByTeamViewController
final class PlayersByTeamView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var teamPlayerTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: PlayersByTeamCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        $0.showsVerticalScrollIndicator = true
        $0.alpha = 0
        return $0
    }(UITableView())
    
    public lazy var activityIndicator = ActivityIndicatorView(color: .systemRed, style: .large)
    
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
        addSubview(teamPlayerTableView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            teamPlayerTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            teamPlayerTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            teamPlayerTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            teamPlayerTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: teamPlayerTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: teamPlayerTableView.centerYAnchor)
        ])
    }
    
}
