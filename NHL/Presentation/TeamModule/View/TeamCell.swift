//
//  TeamCell.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

/// Class contains UIElements and methods for TeamCell
final class TeamCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var teamImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    // MARK: - Private Properties
    
    private let teamTitleLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = .avenirNextMediumOfSize(18)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(UILabel())
    
    private lazy var labelAndImageStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [teamTitleLabel, teamImageView]))
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupTeamImageView()
    }
    
    // MARK: - Public Methods
    
    public func configureCell(with item: TeamScreenModelProtocol) {
        teamTitleLabel.text = item.name
        teamImageView.image = item.image
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.superview?.backgroundColor = .black
    }
    
    private func setupTeamImageView() {
        teamImageView.roundViewWith(cornerRadius: teamImageView.bounds.width / 2)
    }
    
    private func addSubviews() {
        contentView.addSubview(labelAndImageStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelAndImageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelAndImageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelAndImageStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelAndImageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            teamImageView.widthAnchor.constraint(equalToConstant: 70),
        ])
    }
    
}
