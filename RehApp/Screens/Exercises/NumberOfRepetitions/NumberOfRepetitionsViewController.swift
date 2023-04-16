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

    private let numberOfRepetitionsView = DefaultCollectionViewWithLargeButton(largeButtonTitle: "Nastavi".uppercased())
    private var collectionViewDataSource: NumberOfRepetitionsCollectionViewDataSource!
    private let pickerDataSource: NumberOfRepetitionsPickerDataSource
    private let exerciseVMs: [ExerciseDetailsVM]

    let numberOfRepetitions = [4, 5, 6, 7, 8, 9, 10, 11, 12]

    // MARK: - Lifecycle

    init(exerciseVMs: [ExerciseDetailsVM]) {
        self.exerciseVMs = exerciseVMs
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
            cell.selectPickerMiddleItem { selectedIndex in
                let selectedItem = self.numberOfRepetitions[selectedIndex]
                UserDefaults.standard.set(selectedItem, forKey: GlobalSettings.numberOfRepetitionsSelectedKey)
            }
        }

        collectionViewDataSource = NumberOfRepetitionsCollectionViewDataSource(collectionView: numberOfRepetitionsView.collectionView,
                                                                               cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: numberOfRepetitionsCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })
    }

    private func configureProperties() {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            _ = RehAppExercisesFlowCoordinator(exerciseViewModels: exerciseVMs,
                                               navigationController: navigationController)
        }
        numberOfRepetitionsView.setLargeButtonAction(action)
    }

}
