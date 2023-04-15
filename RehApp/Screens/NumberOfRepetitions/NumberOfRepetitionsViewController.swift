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
    private var collectionViewDataSource: NumberOfRepetitionsCollectionViewDataSource!
    private let pickerDataSource: NumberOfRepetitionsPickerDataSource

    let numberOfRepetitions = [4, 5, 6, 7, 8, 9, 10, 11, 12]

    // MARK: - Lifecycle

    init() {
        pickerDataSource = NumberOfRepetitionsPickerDataSource(numberOfRepetitions: numberOfRepetitions)
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

        collectionViewDataSource.rebuildSnapshot(animatingDifferences: true)
    }

    private func configureDataSourceCellRegistrations() {
        let numberOfRepetitionsCellRegistration = UICollectionView.CellRegistration<NumberOfRepetitionsCell, Int> { [weak self] (cell, _, _) in
            guard let self = self else { return }
            cell.setPickerViewDataSource(pickerDataSource)
            cell.setPickerViewDelegate(self)
            cell.selectPickerMiddleItem()
        }

        collectionViewDataSource = NumberOfRepetitionsCollectionViewDataSource(collectionView: numberOfRepetitionsView.collectionView,
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
