//
//  GameViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 03.01.2022.
//

import UIKit

/// Class displays game info of specific game according to entered year, type and number of the game
final class GameViewController: UIViewController, LoadableGameIDAlertController, LoadableErrorAlertController {
    
    // MARK: - Public Properties
    
    public var presenter: GamePresenterOutputDelegate?
    
    // MARK: - Private Properties
    
    private lazy var mainView = GameView()
    private var coordinator: MainCoordinator
    private var gameData: GameDTO?
    private var gameID = 0
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupPresenter()
        setupNavBar()
        setupCallback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gameIDAlertHandler()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateView()
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
    
    private func updateView() {
        mainView.hideView()
    }
    
    private func setupView() {
        mainView.hostTeamTableView.delegate = self
        mainView.hostTeamTableView.dataSource = self
        mainView.guestTeamTableView.delegate = self
        mainView.guestTeamTableView.dataSource = self
    }
    
    private func setupCallback() {
        mainView.hostRefreshControlPulled = { [weak self] in
            guard let self = self else { return }
            self.presenter?.getData(with: self.gameID, completion: {_ in })
        }
        
        mainView.guestRefreshControlPulled = { [weak self] in
            guard let self = self else { return }
            self.presenter?.getData(with: self.gameID, completion: {_ in })
        }
    }
    
    private func gameIDAlertHandler() {
        presenter?.showAlert()
    }
    
    private func setupPresenter() {
        presenter = GamePresenter(delegate: self)
    }
    
    private func setupNavBar() {
        setupNavBarWith(
            title: AppLabel.gameVC,
            font: .avenirNextHeavyItalic(35),
            image: AppImage.nabBarBG
        )
    }
    
}

// MARK: - UITableViewDataSource

extension GameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainView.hostTeamTableView {
            let hostCell: HostStatsCell = tableView.dequeueCell(for: indexPath)
            guard let item = gameData else { return hostCell }
            hostCell.configureCell(with: item, at: indexPath)
            return hostCell
        }
        if tableView == mainView.guestTeamTableView {
            let guestCell: GuestStatsCell = tableView.dequeueCell(for: indexPath)
            guard let item = gameData else { return guestCell }
            guestCell.configureCell(with: item, at: indexPath)
            return guestCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == mainView.hostTeamTableView {
            let headerView = createHeaderView(for: tableView, with: AppLabel.hostStats, color: .systemGreen)
            return headerView
        }
        if tableView == mainView.guestTeamTableView {
            let headerView = createHeaderView(for: tableView, with: AppLabel.guestStats, color: .systemRed)
            return headerView
        }
        return UIView()
    }
    
}

// MARK: - UITableViewDelegate

extension GameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AppCell.minRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicators.vertical?.backgroundColor = .systemRed
    }
    
}

// MARK: - GamePresenterInputDelegate

extension GameViewController: GamePresenterInputDelegate {
    func showFailureAlert(with error: Error) {
        showErrorAlertWith(
            title: ConvAlertConstant.message,
            message: error as! AppError) {
                self.presenter?.showAlert()
            } completionCancel: {}

    }
    
    func endRefreshing() {
        mainView.hostTableRefreshControl.endRefreshing()
        mainView.guestTableRefreshControl.endRefreshing()
    }
    
    func startAnimating() { mainView.activityIndicator.startAnimating() }
    func stopAnimating() { mainView.activityIndicator.stopAnimating() }
    
    func reloadView(_ gameData: GameDTO) {
        self.gameData = gameData
        mainView.hostTeamTableView.reloadData()
        mainView.guestTeamTableView.reloadData()
    }
    
    func showGameIDAlert() {
        showGameIDAlert() { gameID, gameYear, gameType, gameNumber in
            self.gameID = gameID
            return self.presenter?.getData(with: gameID, completion: { gameData in
                self.mainView.setupHeaderStackView(
                    with: gameData,
                    year: gameYear,
                    type: GameType(rawValue: gameType) ?? .none,
                    number: gameNumber
                )
            })
        } completionCancel: {}
    }
    
}
