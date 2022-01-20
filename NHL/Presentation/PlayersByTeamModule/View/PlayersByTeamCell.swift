//
//  PlayersByTeamCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 06.01.2022.
//

import UIKit

/// Class contains UIElements and methods for PlayersByTeamCell
final class PlayersByTeamCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var playerImagePlaceholder: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    // MARK: - Private Properties
    
    private let teamTitleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.font = .avenirNextMediumOfSize(18)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private let totalPlayersLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .systemRed
        $0.numberOfLines = 1
        $0.font = .avenirNextDemiBoldOfSize(20)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var labelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [teamTitleLabel, totalPlayersLabel]))
    
    private lazy var labelAndImageStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [labelStackView, playerImagePlaceholder]))
    
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
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupPlayerImagePlaceholder()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: PlayersByTeamScreenModelProtocol) {
        teamTitleLabel.text = item.name
        playerImagePlaceholder.image = item.imgPlayer
        setupTotalPlayerLabel(with: item.totalPlayers)
    }
    
    // MARK: - Private Methods
    
    private func setupTotalPlayerLabel(with text: String) {
        let totalPlayers = AppLabel.totalPlayers
        let nsText = NSMutableAttributedString(string: totalPlayers + text)
        nsText.set(color: .lightGray, for: totalPlayers)
        nsText.set(font: .avenirNextMediumOfSize(16), for: totalPlayers)
        totalPlayersLabel.attributedText = nsText
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
        accessoryView = createAccessoryView(with: .white, image: AppImage.chevronRight)
    }
    
    private func setupPlayerImagePlaceholder() {
        playerImagePlaceholder.roundViewWith(
            cornerRadius: playerImagePlaceholder.bounds.width / 2,
            borderColor: .cyan,
            borderWidth: 2
        )
    }
    
    private func addSubviews() {
        contentView.addSubview(labelAndImageStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelAndImageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelAndImageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelAndImageStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelAndImageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            playerImagePlaceholder.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
    
}
