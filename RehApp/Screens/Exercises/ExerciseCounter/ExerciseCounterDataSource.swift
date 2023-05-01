//
//  ExerciseCounterDataSource.swift
//  RehApp
//
//  Created by Petar Ljubotina on 16.04.2023..
//

import Foundation
import UIKit

final class ExerciseCounterDataSource: UICollectionViewDiffableDataSource<Int, ExerciseDetailsVM> {

    typealias ExerciseCounterSnapshot = NSDiffableDataSourceSnapshot<Int, ExerciseDetailsVM>

    func rebuildSnapshot(viewModel: ExerciseDetailsVM, animatingDifferences: Bool) {
        var snapshot = ExerciseCounterSnapshot()

        snapshot.appendSections([0])
        snapshot.appendItems([viewModel], toSection: 0)

        apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
