//
//  HealthStatisticsSection.swift
//  RehApp
//
//  Created by Akademija on 23.04.2023..
//

import Foundation

enum HealthStatisticsSection: Equatable, Hashable {
    case averageHeartRate([HeartRate])
    case activeEnergy
    case duration

    // MARK: - Computed stored properties

    var averageHeartRates: [HeartRate]? {
        switch self {
        case .averageHeartRate(let viewModel):
            return viewModel
        default:
            return nil
        }
    }

}
