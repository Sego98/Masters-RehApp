//
//  ReminderCell.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation
import UIKit

final class ReminderCell: UITableViewCell {

    static var identifier: String { String(describing: self) }

    // MARK: - Properties

    private let reminderTitleTimeView = ReminderTitleTimeView()
    private let reminderRepeatingSwitchView = ReminderRepeatingSwitchView()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()

    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            backgroundColor = newValue ? .rehAppBackground.withAlphaComponent(0.5) : .rehAppBackground
            super.isHighlighted = newValue
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.backgroundColor = .rehAppBackground

        contentView.addSubviews([
            stackView, separatorLine
        ])

        stackView.addArrangedSubviews([
            reminderTitleTimeView, reminderRepeatingSwitchView
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        let guide = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            separatorLine.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setValues(with viewModel: ReminderVM) {
        reminderTitleTimeView.setValues(name: viewModel.name, time: viewModel.time)
        reminderRepeatingSwitchView.setSwitchState(viewModel.isRepeating)
    }

    func setSwitchAction(_ action: UIAction) {
        reminderRepeatingSwitchView.setSwitchAction(action)
    }
}
