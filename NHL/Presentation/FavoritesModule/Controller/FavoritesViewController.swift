//
//  FavoritesViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 19.01.2022.
//

import UIKit
import RealmSwift

/// Class displays a collection of saved player's images
final class FavoritesViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var presenter: FavoritesPresenterOutputDelegate?

    // MARK: - Private Properties
    
    private var mainView = FavoritesView()
    private let coordinator: MainCoordinator
    private let insetForSection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private var favorites: Results<Favorite>?
    private var realm = RealmService.shared
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        getDataHandler()
        setupView()
        setupNavBar()
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
    
    private func setupPresenter() {
        presenter = FavoritesPresenter(delegate: self)
    }
    
    private func getDataHandler() {
        presenter?.getData()
    }
    
    private func setupNavBar() {
        title = AppLabel.favorites
    }
    
    private func setupView() {
        mainView.favoritesCollectionView.delegate = self
        mainView.favoritesCollectionView.dataSource = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let favorites = favorites,
              favorites.count != 0 else { return 0 }
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: FavoritesCell = collectionView.dequeueCell(for: indexPath)
        guard let item = favorites?[indexPath.row] else { return cell }
        cell.configureCell(with: item)
        cell.onDeleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.realm.delete(item)
            collectionView.reloadData()
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionView.setupItemsPerRow(on: collectionView, with: insetForSection)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        insetForSection
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.scrollIndicators.vertical?.backgroundColor = .systemRed
    }
    
}

// MARK: - FavoritesPresenterInputDelegate

extension FavoritesViewController: FavoritesPresenterInputDelegate {
    
    func fetchDataFromRealm() { favorites = realm.get(Favorite.self) }
    
}
