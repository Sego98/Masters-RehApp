//
//  HealthStatisticsSection.swift
//  RehApp
//
//  Created by Akademija on 23.04.2023..
//

import Foundation

enum HealthStatisticsSection: Equatable, Hashable {
    case averageHeartRate([HeartRateVM])
    case activeEnergy([AverageEnergyBurnedVM])
    case duration([Double])

    // MARK: - Computed stored properties

    var averageHeartRates: [HeartRateVM]? {
        switch self {
        case .averageHeartRate(let viewModel):
            return viewModel
        default:
            return nil
        }
    }

    var activeEnergiesBurned: [AverageEnergyBurnedVM]? {
        switch self {
        case .activeEnergy(let viewModel):
            return viewModel
        default:
            return nil
        }
    }

    var durations: [Double]? {
        switch self {
        case .duration(let durations):
            return durations
        default:
            return nil
        }
    }

}
