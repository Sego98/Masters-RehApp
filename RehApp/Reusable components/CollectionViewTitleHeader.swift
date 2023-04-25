//
//  CollectionViewTitleHeader.swift
//  RehApp
//
//  Created by Akademija on 25.04.2023..
//

import Foundation
import UIKit

final class CollectionViewTitleHeader: UICollectionReusableView {

    static var elementKind: String { String(describing: self) }

    // MARK: - Properties

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(for: .title1, weight: .bold)
        label.numberOfLines = 0
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
        addSubview(headerLabel)

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let guide = layoutMarginsGuide

        let bottomConstraint = headerLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bottomConstraint
        ])
    }

    // MARK: - Public methods

    func setHeaderTitle(_ title: String) {
        headerLabel.text = title
    }
}
