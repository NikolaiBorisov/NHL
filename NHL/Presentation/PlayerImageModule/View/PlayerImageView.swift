//
//  PlayerImageView.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 18.01.2022.
//

import UIKit

/// Protocol contains method for longPressGestureRecognizer
protocol PlayerImageViewDelegate: AnyObject {
    func longPressGestureTapped()
}

/// Class contains UIElements and methods for SingleImageViewController
final class PlayerImageView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: - Public Properties
    
    public var saveButtonTapped: (() -> Void)?
    
    public lazy var singleImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        $0.clipsToBounds = true
        $0.alpha = 0
        $0.addGestureRecognizer(setupLongPressGestureRecognizer())
        return $0
    }(UIImageView())
    
    public var saveButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(AppImage.saveButtonIcon, for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton(type: .system))
    
    // MARK: - Private Properties
    
    private weak var delegate: PlayerImageViewDelegate?
    
    // MARK: - Initializers
    
    init(subscriber: PlayerImageViewDelegate?) {
        self.delegate = subscriber
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        setupLayout()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func longPressGestureTapped(sender: UILongPressGestureRecognizer) {
        delegate?.longPressGestureTapped()
    }
    
    @objc private func onButtonTapped(sender: UIButton) {
        switch sender {
        case saveButton: saveButtonTapped?()
        default: return
        }
    }
    
    // MARK: - Public Methods
    
    /// Animate alpha of any view
    public func animate(view: UIView) {
        UIView.animate(
            withDuration: 0.7,
            delay: 0.0,
            options: .curveEaseIn
        ) {
            view.alpha = 1
        }
    }
    
    // MARK: - Private Methods
    
    private func setupButtonAction() {
        saveButton.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    private func setupLongPressGestureRecognizer() -> UILongPressGestureRecognizer {
        let gestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longPressGestureTapped)
        )
        gestureRecognizer.delegate = self
        gestureRecognizer.minimumPressDuration = 1
        return gestureRecognizer
    }
    
    private func setupView() {
        backgroundColor = .black
        singleImageView.roundViewWith(cornerRadius: 10)
    }
    
    private func addSubviews() {
        addSubview(singleImageView)
        // addSubview(firstAndLastNameStackView)
        singleImageView.addSubview(saveButton)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            singleImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            singleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            singleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            singleImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}
