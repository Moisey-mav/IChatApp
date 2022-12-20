//
//  ProfileSettingsCell.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 17.12.2022.
//

import UIKit

class ProfileSettingsCell: UITableViewCell {
    static let identifier = "ProfileSettingsCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .headerTextField()
        return imageView
    }()
    
    private let informLabel = UILabel(text: "Title: Content", font: .avenir15())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        informLabel.text = nil
    }
    
    public func configureSettingCell(with: StaticCellOptions) {
        iconImageView.image = with.icon
        informLabel.text = with.content
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraints
extension ProfileSettingsCell {
    private func setupConstraints() {
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
        ])

        contentView.addSubview(informLabel)
        informLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            informLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10)
            
        ])
    }
}
