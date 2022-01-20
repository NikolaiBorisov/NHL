//
//  PlayersByTeamViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 03.01.2022.
//

import UIKit

/// Class displays players quantity for each team
final class PlayersByTeamViewController: UIViewController, LoadableErrorAlertController {
    
    // MARK: - Public Properties
    
    public var presenter: PlayersByTeamPresenterOutputDelegate?
    
    // MARK: - Private Properties
    
    private lazy var mainView = PlayersByTeamView()
    private var teams: NHLDTO?
    private var coordinator: MainCoordinator
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
        getDataHandler()
    }
    
    // MARK: - Initializers
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        mainView.teamPlayerTableView.delegate = self
        mainView.teamPlayerTableView.dataSource = self
    }
    
    private func getDataHandler() {
        presenter?.getData()
    }
    
    private func setupNavBar() {
        setupNavBarWith(
            title: AppLabel.playerVC,
            font: .avenirNextHeavyItalic(35),
            image: AppImage.nabBarBG
        )
    }
    
}

// MARK: - UITableViewDataSource

extension PlayersByTeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let teams = teams?.teams else { return 1 }
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PlayersByTeamCell else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayersByTeamCell = tableView.dequeueCell(for: indexPath)
        guard let item = teams?.teams[indexPath.row] else { return cell }
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppLabel.players)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension PlayersByTeamViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AppCell.regularRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let team = teams?.teams[indexPath.row] else { return }
        presenter?.didTapOn(team: team)
        let vc = PlayerRosterViewController(
            coordinator: coordinator,
            players: team.roster,
            abbreviation: team.abbreviation
        )
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicators.vertical?.backgroundColor = .systemRed
    }
    
}

// MARK: - PlayersByTeamPresenterInputDelegate

extension PlayersByTeamViewController: PlayersByTeamPresenterInputDelegate {
    
    func startAnimating() {
        mainView.activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        mainView.activityIndicator.stopAnimating()
    }
    
    func presentErrorAlertWith(title: String, message: AppError) {
        showErrorAlertWith(title: title, message: message) {
            self.presenter?.getData()
        } completionCancel: {
            exit(0)
        }
        
    }
    
    func showNextVCWith(team: Team) {
    }
    
    func reloadView(_ teams: NHLDTO) {
        self.teams = teams
        DispatchQueue.main.async {
            self.mainView.teamPlayerTableView.alpha = 1
            self.mainView.teamPlayerTableView.reloadData()
        }
    }
    
}
