//
//  PickerDataSource.swift
//  RehApp
//
//  Created by Petar Ljubotina on 26.04.2023..
//

import Foundation
import UIKit

final class PickerDataSource: UICollectionViewDiffableDataSource<PickerVM.PickerItemVM, PickerVM.PickerItemVM> {

    typealias PickerSnapshot = NSDiffableDataSourceSnapshot<PickerVM.PickerItemVM, PickerVM.PickerItemVM>

    func rebuildSnapshot(items: [PickerVM.PickerItemVM], animateDifferences: Bool) {
        var snapshot = PickerSnapshot()

        for item in items {
            snapshot.appendSections([item])
            snapshot.appendItems([item], toSection: item)
        }
//        snapshot.appendSections([0])

        apply(snapshot, animatingDifferences: animateDifferences)
    }

}
