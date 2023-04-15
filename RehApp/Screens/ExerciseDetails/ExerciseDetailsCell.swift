//
//  ExerciseDetailsCell.swift
//  RehApp
//
//  Created by Akademija on 14.04.2023..
//

import Foundation
import UIKit

final class ExerciseDetailsCell: UICollectionViewCell {

    // MARK: - Properties

    private let exerciseDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        return label
    }()

    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightPurple
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubviews([
            exerciseDescriptionLabel,
            exerciseImageView
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        let guide = contentView.layoutMarginsGuide

        let bottomConstraint = exerciseImageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            exerciseDescriptionLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            exerciseDescriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            exerciseDescriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            exerciseImageView.topAnchor.constraint(equalTo: exerciseDescriptionLabel.bottomAnchor, constant: 24),
            exerciseImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 40),
            exerciseImageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -40),
            exerciseImageView.heightAnchor.constraint(equalTo: exerciseImageView.widthAnchor),
            bottomConstraint
        ])
    }

    // MARK: - Public methods

    func setExerciseDescription(_ description: String) {
        exerciseDescriptionLabel.text = description
    }
}
