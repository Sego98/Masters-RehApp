//
//  ListAllExercisesDataSource.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllExercisesDataSource: UICollectionViewDiffableDataSource<Int, ExerciseDetailsVM> {

    typealias ListAllItemsSnapshot = NSDiffableDataSourceSnapshot<Int, ExerciseDetailsVM>

    func rebuildSnapshot(items: [ExerciseDetailsVM], animatingDifferences: Bool) {
        var snapshot = ListAllItemsSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        applyOnMainThread(snapshot: snapshot, animatingDifferences: animatingDifferences)
    }

    func applyOnMainThread(snapshot: ListAllItemsSnapshot, animatingDifferences: Bool) {
        DispatchQueue.main.async {
            self.apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }
}
