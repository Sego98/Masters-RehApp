//
//  HealthStatisticsNoItemsCell.swift
//  RehApp
//
//  Created by Akademija on 27.04.2023..
//

import Foundation
import UIKit

final class HealthStatisticsNoItemsCell: UICollectionViewCell {

    // MARK: - Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "info.bubble")
        imageView.tintColor = .lightPurple
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "NoExercises".localize()
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubviews([
            imageView, descriptionLabel
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let guide = contentView.layoutMarginsGuide

        let bottomConstraint = descriptionLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomConstraint.priority = .defaultHigh

        let iconDimension = CGFloat(80)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: iconDimension),
            imageView.widthAnchor.constraint(equalToConstant: iconDimension),
            imageView.topAnchor.constraint(equalTo: guide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bottomConstraint
        ])
    }
}
