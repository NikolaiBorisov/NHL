//
//  DetailedTeamView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 04.01.2022.
//

import UIKit

/// Class contains UIElements and methods for DetailedTeamViewController
final class DetailedTeamView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var teamInfoTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: DetailedTeamCell.self)
        $0.backgroundColor = .black
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.showsVerticalScrollIndicator = false
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
        teamInfoTableView.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
    }
    
    private func addSubviews() {
        addSubview(teamInfoTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            teamInfoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            teamInfoTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            teamInfoTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            teamInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
}
