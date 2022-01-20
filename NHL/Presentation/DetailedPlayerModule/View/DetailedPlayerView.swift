//
//  DetailedPlayerView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Class contains UIElements and methods for DetailedPlayerViewController
final class DetailedPlayerView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var detailedPlayerTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(cell: DetailedPlayerCell.self)
        $0.backgroundColor = .black
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.showsVerticalScrollIndicator = false
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
        detailedPlayerTableView.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
    }
    
    private func addSubviews() {
        addSubview(detailedPlayerTableView)
        detailedPlayerTableView.addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            detailedPlayerTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            detailedPlayerTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            detailedPlayerTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            detailedPlayerTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: detailedPlayerTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: detailedPlayerTableView.centerYAnchor)
        ])
    }
    
}
