//
//  GameView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 12.01.2022.
//

import UIKit

enum GameType: String {
    case type01 = "01"
    case type02 = "02"
    case none = ""
}

fileprivate enum GameInfo: String, CaseIterable {
    case year = "Year: "
    case type = "   Season: "
    case number = "   Game: "
    case preseason = "Preseason"
    case regSeason = "Reg.season"
    
}

/// Class contains UIElements and methods for GameViewController
final class GameView: UIView {
    
    // MARK: - Public Properties
    
    public var hostRefreshControlPulled: (() -> Void)?
    public var guestRefreshControlPulled: (() -> Void)?
    
    public lazy var hostTeamTableView: UITableView = {
        $0.isScrollEnabled = true
        $0.register(cell: HostStatsCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        $0.showsVerticalScrollIndicator = true
        return $0
    }(UITableView())
    
    public lazy var guestTeamTableView: UITableView = {
        $0.isScrollEnabled = true
        $0.register(cell: GuestStatsCell.self)
        $0.contentInsetAdjustmentBehavior = .never
        $0.separatorColor = .lightGray
        $0.backgroundColor = .black
        $0.showsVerticalScrollIndicator = true
        return $0
    }(UITableView())
    
    private lazy var tableStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 5
        $0.alpha = 0
        return $0
    }(UIStackView(arrangedSubviews: [hostTeamTableView, guestTeamTableView]))
    
    public lazy var activityIndicator = ActivityIndicatorView(color: .systemRed, style: .large)
    public lazy var hostTableRefreshControl = RefreshControlFactory.generateWith(color: .systemRed)
    public lazy var guestTableRefreshControl = RefreshControlFactory.generateWith(color: .systemRed)
    
    // MARK: - Private Properties
    
    private let topInfoLabel: InsetsLabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .avenirNextMediumOfSize(16)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        $0.alpha = 0
        return $0
    }(InsetsLabel())
    
    // MARK: - HostsSection
    
    private let hostLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .systemGreen
        $0.font = .avenirNextDemiBoldOfSize(25)
        $0.text = AppLabel.hosts
        return $0
    }(UILabel())
    
    private var hostTeamImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let hostTeamNameLabel: InsetsLabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        $0.font = .avenirNextMediumOfSize(20)
        return $0
    }(InsetsLabel())
    
    private let hostScoreLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .avenirNextMediumOfSize(25)
        return $0
    }(UILabel())
    
    private lazy var hostTeamStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [hostLabel, hostTeamImageView, hostTeamNameLabel, hostScoreLabel]))
    
    // MARK: - GuestsSection
    
    private let guestLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .systemRed
        $0.font = .avenirNextDemiBoldOfSize(25)
        $0.text = AppLabel.guests
        return $0
    }(UILabel())
    
    private var guestTeamImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let guestTeamNameLabel: InsetsLabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        $0.font = .avenirNextMediumOfSize(20)
        return $0
    }(InsetsLabel())
    
    private let guestScoreLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .avenirNextMediumOfSize(25)
        return $0
    }(UILabel())
    
    private lazy var guestTeamStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [guestLabel, guestTeamImageView, guestTeamNameLabel, guestScoreLabel]))
    
    // MARK: - Colon
    
    private let colonLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .avenirNextMediumOfSize(40)
        $0.text = AppLabel.colon
        return $0
    }(UILabel())
    
    // MARK: - MainStackView
    
    private lazy var hostAndGuestStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alpha = 0
        return $0
    }(UIStackView(arrangedSubviews: [hostTeamStackView, guestTeamStackView]))
    
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
        hostRefreshControlPulled?()
        guestRefreshControlPulled?()
    }
    
    // MARK: - Public Methods
    
    public func hideView() {
        topInfoLabel.alpha = 0
        hostAndGuestStackView.alpha = 0
        tableStackView.alpha = 0
    }
    
    public func setupHeaderStackView(
        with item: GameViewModelProtocol,
        year: String,
        type: GameType,
        number: String
    ) {
        let gameType = checkGameType(of: type.rawValue)
        let gameNumber = "\(number.drop(while: { $0 == "0"} ))"
        showView()
        setupTopInfoLabel(with: year, gameType, gameNumber)
        setupHostSection(with: item)
        setupGuestSection(with: item)
    }
    
    // MARK: - Private Methods
    
    public func showView() {
        topInfoLabel.alpha = 1
        hostAndGuestStackView.alpha = 1
        tableStackView.alpha = 1
    }
    
    private func setupHostSection(with item: GameViewModelProtocol) {
        hostTeamImageView.image = item.imageHost
        hostTeamNameLabel.text = item.teamHostName
        hostScoreLabel.text = item.scoreHost
    }
    
    private func setupGuestSection(with item: GameViewModelProtocol) {
        guestTeamImageView.image = item.imageGuest
        guestTeamNameLabel.text = item.teamGuestName
        guestScoreLabel.text = item.scoreGuest
    }
    
    private func checkGameType(of type: GameType.RawValue) -> String {
        var specifiedType = type
        switch type {
        case "01": specifiedType = GameInfo.preseason.rawValue
        case "02": specifiedType = GameInfo.regSeason.rawValue
        default: return ""
        }
        return specifiedType
    }
    
    private func setupTopInfoLabel(
        with year: String,
        _ type: String,
        _ number: String
    ) {
        let prefix = GameInfo.allCases
        let nsText = NSMutableAttributedString(
            string: (prefix[0].rawValue + year) +
            (prefix[1].rawValue + type) +
            (prefix[2].rawValue + number)
        )
        nsText.set(color: .cyan, for: prefix[0].rawValue)
        nsText.set(color: .cyan, for: prefix[1].rawValue)
        nsText.set(color: .cyan, for: prefix[2].rawValue)
        topInfoLabel.attributedText = nsText
    }
    
    private func setupRefreshControl() {
        hostTeamTableView.refreshControl = hostTableRefreshControl
        guestTeamTableView.refreshControl = guestTableRefreshControl
        hostTableRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        guestTableRefreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .black
        hostAndGuestStackView.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
        topInfoLabel.roundViewWith(cornerRadius: 5, borderColor: .lightGray, borderWidth: 2)
        hostTeamTableView.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
        guestTeamTableView.roundViewWith(cornerRadius: 10, borderColor: .lightGray, borderWidth: 2)
    }
    
    private func addSubviews() {
        addSubview(topInfoLabel)
        addSubview(hostAndGuestStackView)
        hostAndGuestStackView.addSubview(colonLabel)
        addSubview(tableStackView)
        tableStackView.addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            topInfoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            topInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            hostAndGuestStackView.topAnchor.constraint(equalTo: topInfoLabel.bottomAnchor, constant: 5),
            hostAndGuestStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostAndGuestStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            hostTeamImageView.heightAnchor.constraint(equalToConstant: 100),
            guestTeamImageView.heightAnchor.constraint(equalToConstant: 100),
            
            colonLabel.centerXAnchor.constraint(equalTo: hostAndGuestStackView.centerXAnchor),
            colonLabel.centerYAnchor.constraint(equalTo: hostAndGuestStackView.centerYAnchor),
            colonLabel.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: hostAndGuestStackView.bottomAnchor, constant: 5),
            tableStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: tableStackView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableStackView.centerYAnchor)
        ])
    }
    
}
