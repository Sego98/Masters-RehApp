//
//  HKUnit.swift
//  RehApp
//
//  Created by Akademija on 22.04.2023..
//

import HealthKit

extension HKUnit {

    static func preferredUnit(_ quantityIdentifier: HKQuantityTypeIdentifier) -> HKUnit? {
        switch quantityIdentifier {
        case .activeEnergyBurned:
            return .kilocalorie()
        case .heartRate:
            return .count().unitDivided(by: .minute())
        default:
            return nil
        }
    }
}
