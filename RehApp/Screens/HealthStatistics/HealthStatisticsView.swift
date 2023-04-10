//
//  HealthStatisticsView.swift
//  RehApp
//
//  Created by Akademija on 10.04.2023..
//

import Foundation
import UIKit

final class HealthStatisticsView: UIView {

    // MARK: - Properties

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(for: .title1, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let heightView = KeyValueView()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .rehAppBackground

        addSubview(stackView)
        stackView.addArrangedSubviews([
            nameLabel, heightView
        ])

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let guide = layoutMarginsGuide

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setValues(name: String, height: Int) {
        nameLabel.text = name
        heightView.setValues(key: "Visina", value: String(height))
    }
}
