//
//  NumberOfRepetitionsViewController.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit

final class NumberOfRepetitionsViewController: RehAppViewController {

    // MARK: - Properties

    private let numberOfRepetitionsView = DefaultView(largeButtonTitle: "Nastavi".uppercased())
    private var dataSource: NumberOfRepetitionsDataSource!

    // MARK: - Lifecycle

    init() {
        super.init(screenTitle: "Broj ponavljanja", type: .exercises)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = numberOfRepetitionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureDataSourceCellRegistrations()
        configureProperties()

        dataSource.rebuildSnapshot(animatingDifferences: true)
    }

    private func configureDataSourceCellRegistrations() {
        let numberOfRepetitionsCellRegistration = UICollectionView.CellRegistration<NumberOfRepetitionsCell, Int> {_, _, _ in
        }

        dataSource = NumberOfRepetitionsDataSource(collectionView: numberOfRepetitionsView.collectionView,
                                            cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: numberOfRepetitionsCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })
    }

    private func configureProperties() {
        let action = UIAction { _ in

        }
        numberOfRepetitionsView.setLargeButtonAction(action)
    }

}
