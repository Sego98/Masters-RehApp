//
//  NumberOfRepetitionsDataSource.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation
import UIKit

final class NumberOfRepetitionsDataSource: UICollectionViewDiffableDataSource<Int, Int> {

    typealias NumberOfRepetitionsSnapshot = NSDiffableDataSourceSnapshot<Int, Int>

    func rebuildSnapshot(animatingDifferences: Bool) {
        var snapshot = NumberOfRepetitionsSnapshot()

        snapshot.appendSections([0])
        snapshot.appendItems([0], toSection: 0)

        apply(snapshot, animatingDifferences: animatingDifferences)
    }
}