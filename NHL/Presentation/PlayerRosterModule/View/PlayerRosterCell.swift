//
//  PlayerRosterCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Class contains methods and UIElements for PlayerRosterCell
final class PlayerRosterCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var jerseyNumberLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.backgroundColor = .black
        $0.numberOfLines = 1
        $0.font = .avenirNextHeavyItalic(25)
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    // MARK: - Private Properties
    
    private let playerNameLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.font = .avenirNextHeavyItalic(20)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private let positionLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .lightGray
        $0.numberOfLines = 1
        $0.font = .avenirNextDemiBoldOfSize(18)
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
    }(UIStackView(arrangedSubviews: [playerNameLabel, positionLabel]))
    
    private lazy var mainStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [labelStackView, jerseyNumberLabel]))
    
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
        
        setupJerseyNumberLabel()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: PlayerRosterScreenModelProtocol) {
        playerNameLabel.text = item.person.fullName
        jerseyNumberLabel.text = item.jerseyNumber
        positionLabel.text = item.positionStr
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
        accessoryView = createAccessoryView(with: .white, image: AppImage.chevronRight)
    }
    
    private func setupJerseyNumberLabel() {
        jerseyNumberLabel.roundViewWith(
            cornerRadius: jerseyNumberLabel.bounds.width / 2,
            borderColor: .systemRed,
            borderWidth: 4
        )
    }
    
    private func addSubviews() {
        contentView.addSubview(mainStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            jerseyNumberLabel.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
    
}
