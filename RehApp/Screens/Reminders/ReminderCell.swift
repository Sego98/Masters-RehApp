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

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()

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

        contentView.addSubview(nameLabel)

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let guide = contentView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setValues(with viewModel: ReminderVM) {
        nameLabel.text = viewModel.name.appending(Formatters.dateFormatter.string(from: viewModel.date))
    }
}
