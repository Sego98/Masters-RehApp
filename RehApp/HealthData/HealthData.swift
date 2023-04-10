//
//  HealthData.swift
//  RehApp
//
//  Created by Akademija on 10.04.2023..
//

import Foundation
import HealthKit

class HealthData {

    static let healthStore = HKHealthStore()

    static var readDataTypes: [HKSampleType] {
        return allHealthDataTypes
    }

    static var shareDataTypes: [HKSampleType] {
        return allHealthDataTypes
    }

    private static var allHealthDataTypes: [HKSampleType] {
        let typeIdentifiers: [String] = [
            HKQuantityTypeIdentifier.height.rawValue,
            HKQuantityTypeIdentifier.bodyMass.rawValue,
            HKQuantityTypeIdentifier.stepCount.rawValue
        ]

        return typeIdentifiers.compactMap({ getSampleType(for: $0) })
    }

    // MARK: - Helper methods

    private static func getSampleType(for identifier: String) -> HKSampleType? {
        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: identifier)
        if let quantityType = HKQuantityType.quantityType(forIdentifier: quantityTypeIdentifier) {
            return quantityType
        }

        let categoryTypeIdentifier = HKCategoryTypeIdentifier(rawValue: identifier)
        if let categoryType = HKCategoryType.categoryType(forIdentifier: categoryTypeIdentifier) {
            return categoryType
        }

        return nil
    }
}
