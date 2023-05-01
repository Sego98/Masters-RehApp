//
//  NumberOfRepetitionsDataSource.swift
//  RehApp
//
//  Created by Petar Ljubotina on 15.04.2023..
//
// swiftlint:disable type_name

import Foundation
import UIKit

final class NumberOfRepetitionsCollectionViewDataSource: UICollectionViewDiffableDataSource<Int, Int> {

    typealias NumberOfRepetitionsSnapshot = NSDiffableDataSourceSnapshot<Int, Int>

    func rebuildSnapshot(animatingDifferences: Bool) {
        var snapshot = NumberOfRepetitionsSnapshot()

        snapshot.appendSections([0])
        snapshot.appendItems([0], toSection: 0)

        apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
