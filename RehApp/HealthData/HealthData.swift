//
//  HealthData.swift
//  RehApp
//
//  Created by Akademija on 10.04.2023..
//

import Foundation
import HealthKit

class HealthData {

    static let shared = HealthData()

    let healthStore = HKHealthStore()

    var readDataTypes: [HKSampleType] {
        return Self.allHealthDataTypes
    }

    var shareDataTypes: [HKSampleType] {
        return Self.allHealthDataTypes
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

    func requestHealthAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
#if DEBUG
            print("Health data is not available on this device.")
#endif
            return
        }

        healthStore.requestAuthorization(toShare: Set(shareDataTypes),
                                         read: Set(readDataTypes)) { success, error in
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

    func getMostRecentQuantitySample(for identifier: HKQuantityTypeIdentifier,
                                     completion: @escaping (Double?, Error?) -> Void) {
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                    end: Date(),
                                                    options: .strictEndDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1

        let sampleType = HKQuantityType(identifier)
        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: predicate,
                                  limit: limit,
                                  sortDescriptors: [sortDescriptor]) {[weak self] (_, samples, error) in
            DispatchQueue.main.async {
                guard let self = self,
                      let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample,
                      let unit = self.getQuantityPreferredUnit(sampleType) else {
                    completion(nil, error)
                    return
                }
                let sampleValue = mostRecentSample.quantity.doubleValue(for: unit)
                completion(sampleValue, nil)
            }
        }
        healthStore.execute(query)
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

    private func getQuantityPreferredUnit(_ sampleType: HKSampleType) -> HKUnit? {

        if sampleType is HKQuantityType {
            let quantityIdentifier = HKQuantityTypeIdentifier(rawValue: sampleType.identifier)

            switch quantityIdentifier {
            case .height:
                return .meter()
            case .bodyMass:
                return .gram()
            default:
                return nil
            }
        }
        return nil
    }
}
