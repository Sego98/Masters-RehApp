//
//  ListAllExercisesCell.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllExercisesCell: UICollectionViewCell {

    // MARK: - Properties

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.textColor = .label
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
    }()

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            contentView.backgroundColor = newValue ? .lightPurple.withAlphaComponent(0.2) : .rehAppBackground
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.backgroundColor = .rehAppBackground

        contentView.addSubviews([
            numberLabel, descriptionLabel, separatorLine
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let guide = contentView.layoutMarginsGuide

        let separatorBottomConstraint = separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        separatorBottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
            numberLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorBottomConstraint
        ])
    }

    // MARK: - Public methods

    func setParameters(number: Int, description: String) {
        numberLabel.text = "\(number)."
        descriptionLabel.text = description
    }

    func setBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
}
