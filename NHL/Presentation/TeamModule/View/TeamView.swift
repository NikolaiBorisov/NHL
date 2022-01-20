//
//  TeamView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

/// Class contains UIElements and methods for TeamViewController
final class TeamView: UIView {
    
    // MARK: - Public Properties
    
    public var refreshControlPulled: (() -> Void)?
    
    public lazy var teamTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: TeamCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        $0.showsVerticalScrollIndicator = true
        return $0
    }(UITableView())
    
    public lazy var activityIndicator = ActivityIndicatorView(color: .systemRed, style: .large)
    public lazy var tableRefreshControl = RefreshControlFactory.generateWith(color: .systemRed)
    
    // MARK: - Private Properties
    
    private let copyrightLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        $0.font = .avenirNextMediumOfSize(15)
        return $0
    }(UILabel())
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
        setupRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func refreshData(sender: UIRefreshControl) {
        refreshControlPulled?()
    }
    
    // MARK: - Public Methods
    
    public func setupCopyrightLabel(with text: String) {
        copyrightLabel.text = text
    }
    
    // MARK: - Private Methods
    
    private func setupRefreshControl() {
        teamTableView.refreshControl = tableRefreshControl
        tableRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .black
        copyrightLabel.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
    }
    
    private func addSubviews() {
        addSubview(copyrightLabel)
        addSubview(teamTableView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            copyrightLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            copyrightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            copyrightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            teamTableView.topAnchor.constraint(equalTo: copyrightLabel.bottomAnchor, constant: 5),
            teamTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            teamTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            teamTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: teamTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: teamTableView.centerYAnchor)
        ])
    }
    
}
