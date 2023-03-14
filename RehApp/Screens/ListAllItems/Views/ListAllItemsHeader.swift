//
//  ListAllItemsHeader.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllItemsHeader: UICollectionReusableView {

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

    private let leftTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private let rightTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .body)
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

        titleView.addSubviews([
            leftTitleLabel, rightTitleLabel
        ])

        titleView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let titleViewGuide = titleView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            titleView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: bottomAnchor),

            leftTitleLabel.topAnchor.constraint(equalTo: titleViewGuide.topAnchor),
            leftTitleLabel.leadingAnchor.constraint(equalTo: titleViewGuide.leadingAnchor),
            leftTitleLabel.bottomAnchor.constraint(equalTo: titleViewGuide.bottomAnchor),

            rightTitleLabel.topAnchor.constraint(equalTo: leftTitleLabel.topAnchor),
            rightTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leftTitleLabel.trailingAnchor, constant: 8),
            rightTitleLabel.trailingAnchor.constraint(equalTo: titleViewGuide.trailingAnchor),
            rightTitleLabel.bottomAnchor.constraint(equalTo: leftTitleLabel.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setValues(with viewModel: ListAllItemsViewModel) {
        descriptionLabel.text = viewModel.screenDescription
        leftTitleLabel.text = viewModel.leftHeaderDescription
        rightTitleLabel.text = viewModel.rightHeaderDescription
    }
}
