//
//  NumberOfRepetitionsView.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation
import UIKit

final class DefaultCollectionViewWithLargeButton: UIView {

    // MARK: - Properties

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: .defaultLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .rehAppBackground
        return collectionView
    }()

    let overlayTimerView = OverlayTimerView()

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

    func activateOverlayTimer() {
        overlayTimerView.timerLabel.text = "3"
        addSubview(overlayTimerView)
        largeButton.isEnabled = false

        NSLayoutConstraint.activate([
            overlayTimerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            overlayTimerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayTimerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayTimerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func deactivateOverlayTimer() {
        overlayTimerView.removeFromSuperview()
        largeButton.isEnabled = true
    }

}
