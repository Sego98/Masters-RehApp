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

        addSubviews([
            repeatingDescriptionLabel, repeatingSwitch
        ])

        NSLayoutConstraint.activate([
            repeatingDescriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            repeatingDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            repeatingDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            repeatingSwitch.centerYAnchor.constraint(equalTo: repeatingDescriptionLabel.centerYAnchor),
            repeatingSwitch.leadingAnchor.constraint(equalTo: repeatingDescriptionLabel.trailingAnchor, constant: 16),
            repeatingSwitch.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - Public methods

    func setSwitchAction(_ action: UIAction) {
        repeatingSwitch.addAction(action, for: .valueChanged)
    }

}
