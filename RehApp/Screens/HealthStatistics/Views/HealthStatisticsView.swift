//
//  HealthStatisticsView.swift
//  RehApp
//
//  Created by Akademija on 10.04.2023..
//

import Foundation
import UIKit
import HealthKit

final class HealthStatisticsView: UIView {

    // MARK: - Properties

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .defaultLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .rehAppBackground
        collectionView.alpha = 0
        return collectionView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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

        addSubviews([
            collectionView, activityIndicator
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    // MARK: - Public methods

    func startSpinner() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.125) { [weak self] in
            guard let self = self else { return }
            collectionView.alpha = 0
        }
    }

    func stopSpinner() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.125) { [weak self] in
            guard let self = self else { return }
            collectionView.alpha = 1
        }
    }
}
