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

    var readDataTypes: [HKSampleType] = {
        let identifiers = [
            HKQuantityTypeIdentifier.height.rawValue,
            HKQuantityTypeIdentifier.bodyMass.rawValue,
            HKQuantityTypeIdentifier.heartRate.rawValue,
            HKQuantityTypeIdentifier.heartRateRecoveryOneMinute.rawValue,
            HKQuantityTypeIdentifier.restingHeartRate.rawValue,
            HKQuantityTypeIdentifier.activeEnergyBurned.rawValue
        ]

        return identifiers.compactMap({ getSampleType(for: $0) })
    }()

    var shareDataTypes: [HKSampleType] = {
        return []
    }()

    // MARK: - Public methods

    func requestHealthAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
#if DEBUG
            print("Health data is not available on this device.")
#endif
            completion(false)
            return
        }

        healthStore.requestAuthorization(toShare: Set(shareDataTypes),
                                         read: Set(readDataTypes)) { success, error in
            if let error = error {
                completion(false)
#if DEBUG
                print(error.localizedDescription)
#endif
                return
            }

            if success {
#if DEBUG
                print("HealthKit authorization has been successful!")
#endif
            } else {
#if DEBUG
                print("HealthKit authorization was not successful. :(")
#endif
            }
            completion(success)
        }
    }

    func fetchMostRecentQuantitySample(for identifier: HKQuantityTypeIdentifier,
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
        healthStore.execute(query)
    }

    func fetchDailyStatistics(identifier: HKQuantityTypeIdentifier,
                              fromDate startDate: Date,
                              completion: @escaping (HKStatisticsCollection?) -> Void ) {
        let quantitySampleType = HKQuantityType(identifier)
        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: nil,
                                                    options: .strictStartDate)
        let anchorDate = getAnchorDate()
        let daily = DateComponents(day: 1)

        let query = HKStatisticsCollectionQuery(quantityType: quantitySampleType,
                                                quantitySamplePredicate: predicate,
                                                anchorDate: anchorDate,
                                                intervalComponents: daily)

        query.initialResultsHandler = { _, results, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(results)
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

    private func getAnchorDate() -> Date {
        var anchorComponents = Calendar.current.dateComponents([.day, .month, .year, .weekday], from: Date())
        let offset = (7 + (anchorComponents.weekday ?? 0) - 2) % 7
        anchorComponents.day! -= offset
        anchorComponents.hour = 3

        return Calendar.current.date(from: anchorComponents)!
    }
}
