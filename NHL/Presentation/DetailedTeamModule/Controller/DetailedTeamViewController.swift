//
//  DetailedTeamViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 30.12.2021.
//

import UIKit

/// Class displays detailed info of selected NHL Team
final class DetailedTeamViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var presenter: DetailedTeamPresenterOutputDelegate?
    
    // MARK: - Private Properties
    
    private var team: DetailedTeamScreenModelProtocol?
    private var coordinator: MainCoordinator?
    private lazy var mainView = DetailedTeamView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
    }
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        team: DetailedTeamScreenModelProtocol
    ) {
        self.coordinator = coordinator
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        title = team?.teamName
    }
    
    private func setupView() {
        mainView.teamInfoTableView.delegate = self
        mainView.teamInfoTableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension DetailedTeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        team?.numberOfRows ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailedTeamCell = tableView.dequeueCell(for: indexPath)
        guard let model = team else { return cell }
        cell.configureCell(with: model, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: AppLabel.teamInfo, color: .cyan)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension DetailedTeamViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return AppCell.imageRowHeight
        default: return AppCell.regularRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = team?.officialSiteURL else { return }
        switch indexPath.row {
        case 9: presenter?.openSiteWith(url: url)
        default: break
        }
    }
    
}

// MARK: - DetailedTeamPresenterInputDelegate

extension DetailedTeamViewController: DetailedTeamPresenterInputDelegate {}
