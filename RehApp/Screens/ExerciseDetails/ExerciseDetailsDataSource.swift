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
