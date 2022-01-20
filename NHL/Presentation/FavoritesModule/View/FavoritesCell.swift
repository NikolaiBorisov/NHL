//
//  FavoritesCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 19.01.2022.
//

import UIKit

/// Class contains UIElement and methods for FavoritesCell
final class FavoritesCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    public var onDeleteButtonTapped: (() -> Void)?
    
    override var isSelected: Bool {
        didSet {
            isSelected ? addBorderForSelectedCell() : removeBorderForUnselectedCell()
        }
    }
    
    // MARK: - Private Properties
    
    private var favoritesImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private var deleteButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(AppImage.trash, for: .normal)
        $0.tintColor = .systemRed
        $0.alpha = 0
        return $0
    }(UIButton(type: .system))
    
    private let playerNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = .avenirNextMediumOfSize(16)
        $0.textColor = .white
        $0.text = "First Name"
        return $0
    }(UILabel())
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupView()
        setupLayout()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favoritesImageView.image = nil
    }
    
    // MARK: - Actions
    
    @objc private func onDeleteTapped(sender: UIButton) {
        onDeleteButtonTapped?()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: Favorite) {
        favoritesImageView.setupImage(with: item.image, for: favoritesImageView, completion: {})
        playerNameLabel.text = item.playerName
    }
    
    // MARK: - Private Methods
    
    private func setupButtonAction() {
        deleteButton.addTarget(self, action: #selector(onDeleteTapped), for: .touchUpInside)
    }
    
    private func addBorderForSelectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.layer.borderColor = UIColor.black.cgColor
            self.contentView.layer.borderWidth = 2
            self.contentView.layer.borderColor = UIColor.cyan.cgColor
            self.deleteButton.alpha = 1
        }
    }
    
    private func removeBorderForUnselectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.layer.borderColor = UIColor.black.cgColor
            self.deleteButton.alpha = 0
        }
    }
    
    private func setupView() {
        contentView.backgroundColor = .black
        contentView.roundViewWith(cornerRadius: 5)
        favoritesImageView.roundViewWith(cornerRadius: 5)
    }
    
    private func addSubviews() {
        contentView.addSubview(favoritesImageView)
        contentView.addSubview(playerNameLabel)
        contentView.addSubview(deleteButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            favoritesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoritesImageView.bottomAnchor.constraint(equalTo: playerNameLabel.topAnchor, constant: -5),
            favoritesImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            playerNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            playerNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            playerNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            deleteButton.trailingAnchor.constraint(equalTo: favoritesImageView.trailingAnchor, constant: -10),
            deleteButton.topAnchor.constraint(equalTo: favoritesImageView.topAnchor, constant: 10),
            deleteButton.widthAnchor.constraint(equalToConstant: 25),
            deleteButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}
