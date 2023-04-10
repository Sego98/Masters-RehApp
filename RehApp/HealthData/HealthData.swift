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

    // MARK: - Public methods

    static func requestHealthAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
#if DEBUG
            print("Health data is not available on this device.")
#endif
            return
        }

        Self.healthStore.requestAuthorization(toShare: Set(HealthData.shareDataTypes),
                                              read: Set(HealthData.readDataTypes)) { success, error in
            if success {
#if DEBUG
                print("HealthKit authorization has been successful!")
#endif
            } else {
#if DEBUG
                print("HealthKit authorization was not successful. :(")
#endif
            }

            if let error = error {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }

    static func getMostRecentQuantitySample(for sampleType: HKSampleType,
                                            completion: @escaping (HKQuantitySample?, Error?) -> Void) {
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                    end: Date(),
                                                    options: .strictEndDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1

        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: predicate,
                                  limit: limit,
                                  sortDescriptors: [sortDescriptor]) { (_, samples, error) in
            DispatchQueue.main.async {
                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else {
                    completion(nil, error)
                    return
                }
                completion(mostRecentSample, nil)
            }
        }
        Self.healthStore.execute(query)
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
