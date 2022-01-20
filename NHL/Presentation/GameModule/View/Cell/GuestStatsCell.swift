//
//  GuestStatsCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 14.01.2022.
//

import UIKit

/// Class provides methods and UIElements for GuestStatsCell
final class GuestStatsCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var statsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .right
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
    
    public func configureCell(with item: GuestStatsCellModelProtocol, at indexPath: IndexPath) {
        switch indexPath.row {
        case 0: setupCell(with: .goals, text: item.goalsG, at: indexPath)
        case 1: setupCell(with: .pims, text: item.pimsG, at: indexPath)
        case 2: setupCell(with: .shots, text: item.shotsG, at: indexPath)
        case 3: setupCell(with: .powerPlayPercentage, text: item.powerPlayPercentageG, at: indexPath)
        case 4: setupCell(with: .powerPlayGoals, text: item.powerPlayGoalsG, at: indexPath)
        case 5: setupCell(with: .powerPlayOpportunities, text: item.powerPlayOpportunitiesG, at: indexPath)
        case 6: setupCell(with: .faceOffWinPercentage, text: item.faceOffWinPercentageG, at: indexPath)
        case 7: setupCell(with: .blocks, text: item.blocksG, at: indexPath)
        case 8: setupCell(with: .takeaways, text: item.takeawaysG, at: indexPath)
        case 9: setupCell(with: .giveaways, text: item.giveawaysG, at: indexPath)
        case 10: setupCell(with: .hits, text: item.hitsG, at: indexPath)
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
