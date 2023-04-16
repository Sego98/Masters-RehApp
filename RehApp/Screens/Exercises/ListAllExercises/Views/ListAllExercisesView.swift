//
//  ListAllExercisesView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllExercisesView: UIView {

    // MARK: - Properties

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: customCollectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .rehAppBackground
        return collectionView
    }()

    private static var customCollectionViewLayout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize,
                                                       repeatingSubitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)

        let layout = UICollectionViewCompositionalLayout(section: section)
        let configuration = UICollectionViewCompositionalLayoutConfiguration()

        // Overal header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(1.0))
        let headerKind = ListAllExercisesHeader.elementKind
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: headerKind,
                                                                     alignment: .topLeading)
        configuration.boundarySupplementaryItems = [headerView]
        layout.configuration = configuration

        return layout
    }

    private let largeButton: LargeButton

    // MARK: - Init

    init(viewModel: ListAllExercisesVM) {
        self.largeButton = LargeButton(title: viewModel.largeButtonTitle.uppercased())
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
