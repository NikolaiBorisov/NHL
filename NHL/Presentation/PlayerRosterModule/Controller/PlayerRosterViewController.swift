//
//  PlayerRosterViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Class displays the roster of players according chosen team
final class PlayerRosterViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var presenter: PlayerRosterPresenterOutputDelegate?
    
    // MARK: - Private Properties
    
    private lazy var mainView = PlayerRosterView()
    private var players: TeamRoster?
    private var abbreviation = ""
    private var coordinator: MainCoordinator
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        setupView()
        setupNavBar()
    }
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        players: TeamRoster,
        abbreviation: String
    ) {
        self.coordinator = coordinator
        self.players = players
        self.abbreviation = abbreviation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupPresenter() {
        presenter = PlayerRosterPresenter(delegate: self, coordinator: coordinator)
    }
    
    private func setupView() {
        mainView.playerRosterTableView.delegate = self
        mainView.playerRosterTableView.dataSource = self
    }
    
    private func setupNavBar() {
        title = abbreviation + AppLabel.rosterPlayers
    }
    
}

// MARK: - UITableViewDataSource

extension PlayerRosterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let players = players?.roster else { return 1 }
        return  players.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PlayerRosterCell else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerRosterCell = tableView.dequeueCell(for: indexPath)
        guard let item = players?.roster[indexPath.row] else { return cell }
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppLabel.playersRoster)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension PlayerRosterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AppCell.regularRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let player = players?.roster[indexPath.row] else { return }
        presenter?.didTapOn(player: player)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicators.vertical?.backgroundColor = .systemRed
    }
    
}

// MARK: - PlayerRosterPresenterInputDelegate

extension PlayerRosterViewController: PlayerRosterPresenterInputDelegate {
    
    func showNextVCWith(player: RosterElement) {
        let vc = DetailedPlayerViewController(
            coordinator: coordinator,
            playerID: player.id,
            name: player.person.fullName
        )
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
