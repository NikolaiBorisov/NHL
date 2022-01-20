//
//  TeamViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

/// Class displays the list of NHL Teams
final class TeamViewController: UIViewController, LoadableErrorAlertController {
    
    // MARK: - Public Properties
    
    public var presenter: TeamPresenterOutputDelegate?
    
    // MARK: - Private Properties
    
    private lazy var mainView = TeamView()
    private var teams: NHLDTO?
    private var coordinator: MainCoordinator?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
        getDataHandlerAF()
        setupCallback()
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
        mainView.teamTableView.delegate = self
        mainView.teamTableView.dataSource = self
    }
    
    private func getDataHandlerAF() {
        presenter?.getDataWithAF()
    }
    
    private func setupCallback() {
        mainView.refreshControlPulled = { [weak self] in
            guard let self = self else { return }
            self.presenter?.getDataWithAF()
        }
    }
    
    private func setupNavBar() {
        setupNavBarWith(
            title: AppLabel.nhl,
            font: .avenirNextHeavyItalic(35),
            image: AppImage.nabBarBG
        )
    }
    
}

// MARK: - UITableViewDataSource

extension TeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let teams = teams?.teams else { return 1 }
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TeamCell else { return }
        cell.animateCell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeamCell = tableView.dequeueCell(for: indexPath)
        guard let item = teams?.teams[indexPath.row] else { return cell }
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppLabel.teamsRoster)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension TeamViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AppCell.regularRowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let team = teams?.teams[indexPath.row] else { return }
        presenter?.didTapOn(team: team)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicators.vertical?.backgroundColor = .systemRed
    }
    
}

// MARK: - TeamPresenterInputDelegate

extension TeamViewController: TeamPresenterInputDelegate {
    
    func showNextVCWith(team: DetailedTeamScreenModelProtocol) { coordinator?.pushDetailedScreenWith(team: team) }
    func setupLabel(with text: String) { mainView.setupCopyrightLabel(with: text) }
    func endRefreshing() { mainView.tableRefreshControl.endRefreshing() }
    func startAnimating() { mainView.activityIndicator.startAnimating() }
    func stopAnimating() { mainView.activityIndicator.stopAnimating() }
    
    func presentErrorAlertWith(title: String, message: AppError) {
        showErrorAlertWith(title: title, message: message) {
            self.presenter?.getDataWithAF()
        } completionCancel: {
            exit(0)
        }
    }
    
    func reloadView(_ teams: NHLDTO) {
        self.teams = teams
        DispatchQueue.main.async {
            self.mainView.teamTableView.reloadData()
        }
    }
    
}
