//
//  DetailedPlayerViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 10.01.2022.
//

import UIKit

/// Class provides detailed info about chosen player
final class DetailedPlayerViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var presenter: DetailedPlayerPresenterOutputDelegate?
    
    // MARK: - Private Properties
    
    private var coordinator: MainCoordinator
    private lazy var mainView = DetailedPlayerView()
    private var playerID = 0
    private var playerData: PlayerDTO?
    private var numberOfRows = 12
    private var name = ""
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        setupNavBar()
        setupView()
        getDataHandler()
    }
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        playerID: Int,
        name: String
    ) {
        self.coordinator = coordinator
        self.playerID = playerID
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupPresenter() {
        presenter = DetailedPlayerPresenter(delegate: self)
    }
    
    private func getDataHandler() {
        presenter?.getData(for: playerID)
    }
    
    private func setupNavBar() {
        title = AppLabel.playerInfo
    }
    
    private func setupView() {
        mainView.detailedPlayerTableView.delegate = self
        mainView.detailedPlayerTableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension DetailedPlayerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailedPlayerCell = tableView.dequeueCell(for: indexPath)
        guard let player = playerData?.people.first else { return cell }
        cell.configureCell(with: player, playerID: playerID, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.0))
        let headerLabel = HeaderViewLabelFactory.generateLabelOn(view: tableView, withText: name, color: .cyan)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
}

// MARK: - UITableViewDelegate

extension DetailedPlayerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return AppCell.imageRowHeight
        default: return AppCell.regularRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailedPlayerCell else { return }
        guard let image  = cell.playerImage.image else { return }
        switch indexPath.row {
        case 0:
            let vc = PlayerImageViewController(coordinator: coordinator, title: name, image: image, id: playerID)
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
    
}

// MARK: - DetailedPlayerPresenterInputDelegate

extension DetailedPlayerViewController: DetailedPlayerPresenterInputDelegate {
    func startAnimating() { mainView.activityIndicator.startAnimating() }
    func stopAnimating() { mainView.activityIndicator.stopAnimating() }
    
    func reloadView(_ player: PlayerDTO) {
        playerData = player
        mainView.detailedPlayerTableView.reloadData()
    }
}
