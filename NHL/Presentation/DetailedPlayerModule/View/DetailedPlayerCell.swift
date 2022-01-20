//
//  DetailedPlayerCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

fileprivate enum DetailedInfoPrefix: String {
    case firstName = "First Name:\n"
    case lastName = "Last Name:\n"
    case primaryNumber = "Number:\n"
    case birthDate = "Birth Date:\n"
    case currentAge = "Current Age:\n"
    case birthCity = "Birth City:\n"
    case birthCountry = "Birth Country:\n"
    case nationality = "Nationality:\n"
    case height = "Height:\n"
    case weight = "Weight:\n"
    case primaryPosition = "Position:\n"
}

/// Class provides methods and UIElements for DetailedPlayerCell
final class DetailedPlayerCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public lazy var playerImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    // MARK: - Private Properties
    
    private lazy var activityIndicator = ActivityIndicatorView(color: .systemRed, style: .large)
    
    private lazy var playerInfoLabel: UILabel = {
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
        
        setupPlayerImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        playerInfoLabel.text = nil
        playerImage.image = nil
    }
    
    // MARK: - Public Methods
    
    public func configureCell(
        with item: DetailedPlayerScreenModelProtocol,
        playerID: Int,
        at indexPath: IndexPath
    ) {
        switch indexPath.row {
        case 0: setupImageCell(with: playerID, at: indexPath)
        case 1: setupInfoCell(with: .firstName, text: item.firstName, at: indexPath)
        case 2: setupInfoCell(with: .lastName, text: item.lastName, at: indexPath)
        case 3: setupInfoCell(with: .primaryNumber, text: item.primaryNumber, at: indexPath)
        case 4: setupInfoCell(with: .birthDate, text: item.birthDate, at: indexPath)
        case 5: setupInfoCell(with: .currentAge, text: "\(item.currentAge)", at: indexPath)
        case 6: setupInfoCell(with: .birthCity, text: item.birthCity, at: indexPath)
        case 7: setupInfoCell(with: .birthCountry, text: item.birthCountry, at: indexPath)
        case 8: setupInfoCell(with: .nationality, text: item.nationality, at: indexPath)
        case 9: setupInfoCell(with: .height, text: item.height, at: indexPath)
        case 10: setupInfoCell(with: .weight, text: "\(item.weight)", at: indexPath)
        case 11: setupInfoCell(with: .primaryPosition, text: item.primaryPosition.name, at: indexPath)
        default: break
        }
    }
    
    // MARK: - Private Methods
    
    private func setupImageCell(with id: Int, at indexPath: IndexPath) {
        setupLayout(at: indexPath)
        selectionStyle = .default
        activityIndicator.startAnimating()
        playerImage.setupImage(with: AppURL.playerImageURL(id), for: playerImage) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupInfoCell(with prefix: DetailedInfoPrefix, text: String, at indexPath: IndexPath) {
        setupLayout(at: indexPath)
        let nsText = NSMutableAttributedString(string: prefix.rawValue + text)
        nsText.set(color: .cyan, for: prefix.rawValue)
        nsText.set(font: .avenirNextMediumOfSize(18), for: prefix.rawValue)
        playerInfoLabel.attributedText = nsText
    }
    
    private func setupPlayerImage() {
        playerImage.roundViewWith(cornerRadius: 10)
    }
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
        selectionStyle = .none
    }
    
    private func setupLayout(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            contentView.addSubview(playerImage)
            playerImage.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                playerImage.heightAnchor.constraint(equalToConstant: 150),
                playerImage.widthAnchor.constraint(equalToConstant: 150),
                playerImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                playerImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
                activityIndicator.centerXAnchor.constraint(equalTo: playerImage.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: playerImage.centerYAnchor)
            ])
        default:
            contentView.addSubview(playerInfoLabel)
            NSLayoutConstraint.activate([
                playerInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                playerInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                playerInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
    }
    
}
