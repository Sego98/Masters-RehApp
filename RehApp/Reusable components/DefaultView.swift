//
//  NumberOfRepetitionsView.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation
import UIKit

final class DefaultView: UIView {

    // MARK: - Properties

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: .defaultLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .rehAppBackground
        return collectionView
    }()

    private let largeButton: LargeButton

    // MARK: - Init

    init(largeButtonTitle: String) {
        largeButton = LargeButton(title: largeButtonTitle)
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .rehAppBackground

        addSubviews([
            collectionView, largeButton
        ])

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24)
        let guide = layoutMarginsGuide

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            largeButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            largeButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            largeButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            largeButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setLargeButtonAction(_ action: UIAction) {
        largeButton.addAction(action, for: .touchUpInside)
    }
}
