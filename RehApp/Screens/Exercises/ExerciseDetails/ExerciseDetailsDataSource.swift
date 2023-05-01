//
//  ExerciseDetailsDataSource.swift
//  RehApp
//
//  Created by Petar Ljubotina on 16.03.2023..
//

import Foundation
import UIKit

final class ExerciseDetailsDataSource: UICollectionViewDiffableDataSource<Int, ExerciseDetailsVM> {

    typealias ExerciseDetailsSnapshot = NSDiffableDataSourceSnapshot<Int, ExerciseDetailsVM>

    func rebuildSnapshot(viewModel: ExerciseDetailsVM, animatingDifferences: Bool) {
        var snapshot = ExerciseDetailsSnapshot()

        snapshot.appendSections([0])
        snapshot.appendItems([viewModel], toSection: 0)

        apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
