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

    private static var dataTypes: [HKSampleType] {
        guard let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            return []
        }

        return [
            activeEnergy,
            heartRate,
            HKObjectType.workoutType()
        ]
    }

    private var readDataTypes: [HKSampleType] = {
        return HealthData.dataTypes
    }()

    private var shareDataTypes: [HKSampleType] = {
        return HealthData.dataTypes
    }()

    // MARK: - Request authorization

    func requestHealthAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
#if DEBUG
            print("⛔️ Health data is not available on this device.")
#endif
            completion(false)
            return
        }

        healthStore.requestAuthorization(toShare: Set(shareDataTypes),
                                         read: Set(readDataTypes)) { success, error in
            if let error = error {
                completion(false)
#if DEBUG
                print("❌ Authorization failed with error: \(error.localizedDescription)")
#endif
                return
            }

            if success {
#if DEBUG
                print("✅ HealthKit authorization finished")
#endif
            } else {
#if DEBUG
                print("❌ HealthKit authorization has failed.")
#endif
            }
            completion(success)
        }
    }

    // MARK: - Fetch health data

    func fetchMostRecentQuantitySample(for identifier: HKQuantityTypeIdentifier,
                                       completion: @escaping (Double?, Error?) -> Void) {
        let sampleType = HKQuantityType(identifier)

        let samplePredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                    end: Date(),
                                                    options: .strictEndDate)
        let sourcePredicate = HKQuery.predicateForObjects(from: .default())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            samplePredicate, sourcePredicate
        ])

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1

        let query = HKSampleQuery(sampleType: sampleType,
                                  predicate: predicate,
                                  limit: limit,
                                  sortDescriptors: [sortDescriptor]) { (_, samples, error) in
            guard let samples = samples,
                  let mostRecentSample = samples.first as? HKQuantitySample,
                  let unit = HKUnit.preferredUnit(identifier) else {
                completion(nil, error)
                return
            }
            let sampleValue = mostRecentSample.quantity.doubleValue(for: unit)
            completion(sampleValue, nil)
        }

        healthStore.execute(query)
    }

    func fetchDailyStatistics(identifier: HKQuantityTypeIdentifier,
                              from startDate: Date,
                              completion: @escaping (HKStatisticsCollection?, Error?) -> Void ) {
        let startOfDay = Calendar.current.startOfDay(for: startDate)
        let today = Date()
        let samplesPredicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                           end: today,
                                                           options: [.strictStartDate, .strictEndDate])
        let sourcePredicate = HKQuery.predicateForObjects(from: .default())
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [samplesPredicate, sourcePredicate])

        let daily = DateComponents(day: 1)

        let quantitySampleType = HKQuantityType(identifier)

        let query = HKStatisticsCollectionQuery(quantityType: quantitySampleType,
                                                quantitySamplePredicate: predicate,
                                                options: .preferredOptions(identifier),
                                                anchorDate: startOfDay,
                                                intervalComponents: daily)

        query.initialResultsHandler = { _, results, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(results, nil)
        }

        healthStore.execute(query)
    }

    // MARK: - Helper methods

//    private static func makeSampleType(for identifier: String) -> HKSampleType? {
//        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: identifier)
//        if let quantityType = HKQuantityType.quantityType(forIdentifier: quantityTypeIdentifier) {
//            return quantityType
//        }
//
//        let categoryTypeIdentifier = HKCategoryTypeIdentifier(rawValue: identifier)
//        if let categoryType = HKCategoryType.categoryType(forIdentifier: categoryTypeIdentifier) {
//            return categoryType
//        }
//
//        return nil
//    }

}
