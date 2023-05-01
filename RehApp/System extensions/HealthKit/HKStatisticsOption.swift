//
//  HKStatisticsOption.swift
//  RehApp
//
//  Created by Petar Ljubotina on 22.04.2023..
//

import HealthKit

extension HKStatisticsOptions {

    static func preferredOptions(_ quantityIdentifier: HKQuantityTypeIdentifier) -> HKStatisticsOptions {
        switch quantityIdentifier {
        case .activeEnergyBurned:
            return [.cumulativeSum]
        case .heartRate:
            return [.discreteAverage]
        default:
            return []
        }
    }
}
