//
//  HealthStatisticsDataSource.swift
//  RehApp
//
//  Created by Akademija on 23.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit

final class HealthStatisticsDataSource: UICollectionViewDiffableDataSource<HealthStatisticsSection, HealthStatisticsSection> {

    typealias HealthStatisticsSnapshot = NSDiffableDataSourceSnapshot<HealthStatisticsSection, HealthStatisticsSection>

    func rebuildSnapshot(sections: [HealthStatisticsSection], animateDifferences: Bool) {
        var snapshot = HealthStatisticsSnapshot()

        for section in sections {
            snapshot.appendSections([section])
            snapshot.appendItems([section], toSection: section)
        }

        apply(snapshot, animatingDifferences: animateDifferences)
    }

}
