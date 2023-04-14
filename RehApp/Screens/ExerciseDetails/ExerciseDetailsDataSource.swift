//
//  ExerciseDetailsDataSource.swift
//  RehApp
//
//  Created by Akademija on 16.03.2023..
//

import Foundation
import UIKit

final class ExerciseDetailsDataSource: UICollectionViewDiffableDataSource<Int, ExerciseDetailsViewModel> {

    typealias ExerciseDetailsSnapshot = NSDiffableDataSourceSnapshot<Int, ExerciseDetailsViewModel>

    func rebuildSnapshot(viewModel: ExerciseDetailsViewModel, animatingDifferences: Bool) {
        var snapshot = ExerciseDetailsSnapshot()

        snapshot.appendSections([0])
        snapshot.appendItems([viewModel], toSection: 0)

        apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// final class ExerciseDetailsPickerDataSource: NSObject, UIPickerViewDataSource {
//
//    let numberOfRepetitions: [Int]
//
//    init(numberOfRepetitions: [Int]) {
//        self.numberOfRepetitions = numberOfRepetitions
//        super.init()
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return numberOfRepetitions.count
//    }
// }
