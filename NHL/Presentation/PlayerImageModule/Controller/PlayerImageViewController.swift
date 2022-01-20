//
//  PlayerImageViewController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 18.01.2022.
//

import UIKit
import RealmSwift

/// Class displays an image of chosen player
final class PlayerImageViewController: UIViewController, LoadableInfoAlertController {
    
    // MARK: - Public Properties
    
    public var presenter: PlayerImagePresenterOutputDelegate?
    public lazy var mainView = PlayerImageView(subscriber: self)
    public var vcTitle = ""
    public var singleImage = UIImage()
    public var playerID = 0
    
    // MARK: - Private Properties
    
    private let coordinator: MainCoordinator
    private let realm = RealmService.shared
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        setupImage()
        setupNavBar()
        setupCallback()
    }
    
    // MARK: - Initializers
    
    init(
        coordinator: MainCoordinator,
        title: String,
        image: UIImage,
        id: Int
    ) {
        self.coordinator = coordinator
        self.vcTitle = title
        self.singleImage = image
        self.playerID = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func onRightNavItemTapped(sender: UIBarButtonItem) {
        let vc = FavoritesViewController(coordinator: coordinator)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupPresenter() {
        presenter = PlayerImagePresenter(delegate: self)
    }
    
    private func setupImage() {
        presenter?.setupImage()
    }
    
    private func setupNavBar() {
        title = vcTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem.setupRightNavItem(
            self,
            action: #selector(onRightNavItemTapped),
            icon: AppImage.star
        )
    }
    
    private func setupCallback() {
        mainView.saveButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.showInfoAlertWith(
                title: InfoAlertConstant.title1,
                message: InfoAlertConstant.message1) { [weak self] in
                    guard let self = self else { return nil }
                    self.saveDataHandler()
                    self.showInfoAlertWith(
                        title: InfoAlertConstant.title2,
                        message: InfoAlertConstant.message2) {
                            let vc = FavoritesViewController(coordinator: self.coordinator)
                            return self.navigationController?.pushViewController(vc, animated: true)
                        } completionCancel: {}
                    return self.mainView.saveButton.isHidden = true
                } completionCancel: {}
        }
    }
    
    private func saveDataHandler() {
        let fav = Favorite()
        fav.playerName = vcTitle
        fav.image = AppURL.playerImageURL(playerID)
        realm.create(fav, completion: {})
    }
    
}

// MARK: - PlayerImageViewDelegate

extension PlayerImageViewController: PlayerImageViewDelegate {
    
    func longPressGestureTapped() {
        presenter?.createActivityViewController(with: singleImage)
    }
    
}

// MARK: - PlayerImagePresenterInputDelegate

extension PlayerImageViewController: PlayerImagePresenterInputDelegate {
    
    func present(vc: UIActivityViewController) { present(vc, animated: true)}
    func animateView() { mainView.animate(view: mainView.singleImageView) }
    func setupView() { mainView.singleImageView.image = singleImage }
    
}
