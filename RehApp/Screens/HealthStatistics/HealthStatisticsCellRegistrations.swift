//
//  HealthStatisticsCellRegistrations.swift
//  RehApp
//
//  Created by Akademija on 28.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit
import SwiftUI

struct HealthStatisticsCellRegistrations {

    let averageHeartRateCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
        guard let heartRates = item.averageHeartRates else { return }
        cell.contentConfiguration = UIHostingConfiguration(content: {
            AverageHeartRateCellView(heartRates: heartRates)
        })
    }

    let activeEnergyBurnedCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
        guard let energiesBurned = item.activeEnergiesBurned else { return }
        cell.contentConfiguration = UIHostingConfiguration(content: {
            EnergyBurnedCellView(energiesBurned: energiesBurned)
        })
    }

    let durationsCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
        guard let durations = item.durations else { return }
        cell.contentConfiguration = UIHostingConfiguration(content: {
            DurationCellView(durations: durations)
        })
    }

    let timesOfDayCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
        guard let timesOfDay = item.timesOfDay else { return }
        cell.contentConfiguration = UIHostingConfiguration(content: {
            TimeOfDayCellView(timesOfDay: timesOfDay)
        })
    }

    let noItemsCellRegistration = UICollectionView.CellRegistration<HealthStatisticsNoItemsCell, HealthStatisticsSection> { _, _, _ in
    }

}
