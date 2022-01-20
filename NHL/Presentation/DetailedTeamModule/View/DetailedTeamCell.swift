//
//  DetailedTeamCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 04.01.2022.
//

import UIKit

fileprivate enum DetailedInfoPrefix: String {
    case fullName = "Full Name:\n"
    case city = "City:\n"
    case timeZone = "Time Zone:\n"
    case abbreviation = "Abbreviation:\n"
    case firstYearOfPlay = "First Year of Play:\n"
    case division = "Division:\n"
    case conference = "Conference:\n"
    case venue = "Venue:\n"
    case officialSite = "Official Site"
}

/// Class contains UIElements and methods for DetailedTeamCell
final class DetailedTeamCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var teamIcon: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var teamInfoLabel: UILabel = {
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupTeamIcon()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: DetailedTeamScreenModelProtocol, at indexPath: IndexPath) {
        switch indexPath.row {
        case 0: setupIconCell(with: item.image ?? AppImage.imgPlaceholder, at: indexPath)
        case 1: setupInfoCell(with: .fullName, text: item.name, at: indexPath)
        case 2: setupInfoCell(with: .city, text: item.city, at: indexPath)
        case 3: setupInfoCell(with: .timeZone, text: item.timeZone, at: indexPath)
        case 4: setupInfoCell(with: .abbreviation, text: item.abbreviation, at: indexPath)
        case 5: setupInfoCell(with: .firstYearOfPlay, text: item.firstYearOfPlay, at: indexPath)
        case 6: setupInfoCell(with: .division, text: item.divisionStr, at: indexPath)
        case 7: setupInfoCell(with: .conference, text: item.conferenceStr, at: indexPath)
        case 8: setupInfoCell(with: .venue, text: item.venueStr, at: indexPath)
        case 9: setupSiteCell(with: .officialSite, at: indexPath)
        default: break
        }
    }
    
    // MARK: - Private Methods
    
    private func setupIconCell(with icon: UIImage, at indexPath: IndexPath) {
        setupLayout(at: indexPath)
        teamIcon.image = icon
    }
    
    private func setupInfoCell(with prefix: DetailedInfoPrefix, text: String, at indexPath: IndexPath) {
        setupLayout(at: indexPath)
        let nsText = NSMutableAttributedString(string: prefix.rawValue + text)
        nsText.set(color: .cyan, for: prefix.rawValue)
        nsText.set(font: .avenirNextMediumOfSize(18), for: prefix.rawValue)
        teamInfoLabel.attributedText = nsText
    }
    
    private func setupSiteCell(with text: DetailedInfoPrefix, at indexPath: IndexPath) {
        setupLayout(at: indexPath)
        let nsText = NSMutableAttributedString(string: text.rawValue)
        teamInfoLabel.textAlignment = .center
        teamInfoLabel.textColor = .systemBlue
        teamInfoLabel.font = .avenirNextDemiBoldOfSize(20)
        nsText.underlineWith(alpha: 1, color: .systemBlue, for: text.rawValue)
        teamInfoLabel.attributedText = nsText
        selectionStyle = .gray
    }
    
    private func setupTeamIcon() {
        teamIcon.roundViewWith(cornerRadius: 10)
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
        selectionStyle = .none
    }
    
    private func setupLayout(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            contentView.addSubview(teamIcon)
            NSLayoutConstraint.activate([
                teamIcon.heightAnchor.constraint(equalToConstant: 150),
                teamIcon.widthAnchor.constraint(equalToConstant: 150),
                teamIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                teamIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        case 9:
            contentView.addSubview(teamInfoLabel)
            NSLayoutConstraint.activate([
                teamInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                teamInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        default:
            contentView.addSubview(teamInfoLabel)
            NSLayoutConstraint.activate([
                teamInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                teamInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                teamInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    }
    
}
