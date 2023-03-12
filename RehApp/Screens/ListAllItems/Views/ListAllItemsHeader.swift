//
//  ListAllItemsHeader.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllItemsHeader: UITableViewHeaderFooterView {

    static var identifier: String { String(describing: self) }

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
        view.backgroundColor = .systemGray4
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

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(descriptionLabel)
        contentView.addSubview(titleView)
        titleView.addSubview(leftTitleLabel)
        titleView.addSubview(rightTitleLabel)

        let edgeOffset = CGFloat(8)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            leftTitleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: edgeOffset),
            leftTitleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 4),
            leftTitleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -edgeOffset),

            rightTitleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: edgeOffset),
            rightTitleLabel.leadingAnchor.constraint(equalTo: leftTitleLabel.trailingAnchor, constant: 8),
            rightTitleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -4),
            rightTitleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -edgeOffset)
        ])
    }

    func setParameters(itemVM: ListAllItemsViewModel) {
        descriptionLabel.text = itemVM.screenDescription
        leftTitleLabel.text = itemVM.leftHeaderDescription
        rightTitleLabel.text = itemVM.rightHeaderDescription
    }
}
