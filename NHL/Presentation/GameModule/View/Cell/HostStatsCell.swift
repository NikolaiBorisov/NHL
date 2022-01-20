//
//  HostStatsCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 14.01.2022.
//

import UIKit

/// Class provides methods and UIElements for HostStatsCell
final class HostStatsCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var statsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(20)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: HostStatsCellModelProtocol, at indexPath: IndexPath) {
        switch indexPath.row {
        case 0: setupCell(with: .goals, text: item.goalsH, at: indexPath)
        case 1: setupCell(with: .pims, text: item.pimsH, at: indexPath)
        case 2: setupCell(with: .shots, text: item.shotsH, at: indexPath)
        case 3: setupCell(with: .powerPlayPercentage, text: item.powerPlayPercentageH, at: indexPath)
        case 4: setupCell(with: .powerPlayGoals, text: item.powerPlayGoalsH, at: indexPath)
        case 5: setupCell(with: .powerPlayOpportunities, text: item.powerPlayOpportunitiesH, at: indexPath)
        case 6: setupCell(with: .faceOffWinPercentage, text: item.faceOffWinPercentageH, at: indexPath)
        case 7: setupCell(with: .blocks, text: item.blocksH, at: indexPath)
        case 8: setupCell(with: .takeaways, text: item.takeawaysH, at: indexPath)
        case 9: setupCell(with: .giveaways, text: item.giveawaysH, at: indexPath)
        case 10: setupCell(with: .hits, text: item.hitsH, at: indexPath)
        default: break
        }
    }
    
    // MARK: - Private Methods
    
    private func setupCell(with prefix: StatsPrefix, text: String, at indexPath: IndexPath) {
        let nsText = NSMutableAttributedString(string: prefix.rawValue + text)
        nsText.set(color: .cyan, for: prefix.rawValue)
        nsText.set(font: .avenirNextMediumOfSize(15), for: prefix.rawValue)
        statsLabel.attributedText = nsText
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
    }
    
    private func addSubviews() {
        contentView.addSubview(statsLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            statsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            statsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            statsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
