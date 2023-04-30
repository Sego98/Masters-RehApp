//
//  ListAllExercisesHeader.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllExercisesHeader: UICollectionReusableView {

    static var elementKind: String { String(describing: self) }

    // MARK: - Properties

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        return label
    }()

    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightPurple
        return view
    }()

    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    private let leftTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(for: .title3, trait: .bold)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    private let rightTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(for: .title3, trait: .bold)
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
        backgroundColor = .rehAppBackground

        addSubviews([
            descriptionLabel, titleView
        ])

        titleView.addSubview(titleStackView)
        titleStackView.addArrangedSubviews([
            leftTitleLabel, rightTitleLabel
        ])

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24)
        let contentGuide = layoutMarginsGuide

        titleView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 16)
        let titleViewGuide = titleView.layoutMarginsGuide

        let titleStackViewBottomConstraint = titleView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor)
        titleStackViewBottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),

            titleView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            titleView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            titleStackViewBottomConstraint,

            titleStackView.topAnchor.constraint(equalTo: titleViewGuide.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: titleViewGuide.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: titleViewGuide.trailingAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: titleViewGuide.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setValues(with viewModel: ListAllExercisesVM) {
        descriptionLabel.text = viewModel.screenDescription
        leftTitleLabel.text = viewModel.leftHeaderDescription
        rightTitleLabel.text = viewModel.rightHeaderDescription
    }
}
