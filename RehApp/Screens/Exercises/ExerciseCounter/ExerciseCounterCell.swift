//
//  ExerciseCounterCell.swift
//  RehApp
//
//  Created by Akademija on 16.04.2023..
//

import Foundation
import UIKit

final class ExerciseCounterCell: UICollectionViewCell {

    // MARK: - Properties

    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightPurple
        return imageView
    }()

    private let maxRepetitionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        return label
    }()

    private let progressBarView = CircularProgressBarView(radius: 120, barWidth: 25)

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
            exerciseImageView, maxRepetitionsLabel,
            progressBarView
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        let guide = contentView.layoutMarginsGuide

        let bottomConstraint = progressBarView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            exerciseImageView.heightAnchor.constraint(equalToConstant: 200),
            exerciseImageView.widthAnchor.constraint(equalTo: exerciseImageView.heightAnchor),
            exerciseImageView.topAnchor.constraint(equalTo: guide.topAnchor),
            exerciseImageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),

            maxRepetitionsLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 32),
            maxRepetitionsLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            maxRepetitionsLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            progressBarView.topAnchor.constraint(equalTo: maxRepetitionsLabel.bottomAnchor, constant: 32),
            progressBarView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            bottomConstraint
        ])
    }

    // MARK: - Public methods

    func setValues(with viewModel: ExerciseDetailsVM) {
        // notaTODO: configure image
        let maxRepetitions = UserDefaults.standard.integer(forKey: GlobalSettings.numberOfRepetitionsSelectedKey)
        maxRepetitionsLabel.text = "🏋🏽 Broj ponavljanja: \(maxRepetitions)"
    }

    func makeProgressAnimation(_ duration: TimeInterval) {
        progressBarView.progressAnimation(duration: duration)
    }

    func makeCounterLabel() -> UILabel {
        return progressBarView.counterLabel
    }
}
