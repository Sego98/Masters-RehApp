//
//  ReminderRepeatingSwitchView.swift
//  RehApp
//
//  Created by Akademija on 08.04.2023..
//

import Foundation
import UIKit

final class ReminderRepeatingSwitchView: UIView {

    // MARK: - Properties

    private let repeatingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.text = "Ponavljanje svaki dan:"
        return label
    }()

    private let repeatingSwitch: UISwitch = {
        let repeatingSwitch = UISwitch()
        repeatingSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatingSwitch
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .horizontal
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
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        stackView.addArrangedSubviews([
            repeatingDescriptionLabel, repeatingSwitch
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
