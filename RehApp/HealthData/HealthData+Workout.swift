//
//  HealthData+Workout.swift
//  RehApp
//
//  Created by Akademija on 18.04.2023..
//

import Foundation
import HealthKit

extension HealthData {

    /// Method to save a rehabilitation to health data
    func saveRehabilitation(_ rehabilitation: RehabilitationWorkout,
                            completion: @escaping (Bool, Error?) -> Void) {
        guard rehabilitation.duration > 60 else {
#if DEBUG
            print("⛔️ Didn't save the workout because it isn't valid. It needs to last at least 1 min.")
#endif
            completion(false, nil)
            return
        }

        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .other

        let builder = HKWorkoutBuilder(healthStore: healthStore,
                                       configuration: workoutConfiguration,
                                       device: .local())

        builder.beginCollection(withStart: rehabilitation.start) { [weak self] (success, error) in
            guard let self = self else { return }
            guard success else {
                completion(false, error)
                return
            }

            guard let activitySample = makeRehabQuantitySample(identifier: .activeEnergyBurned,
                                                               rehabilitation: rehabilitation),
                  let heartRateSample = makeRehabQuantitySample(identifier: .heartRate,
                                                                rehabilitation: rehabilitation) else {
                completion(false, nil)
                return
            }

            builder.add([activitySample, heartRateSample]) { success, error in
                guard success else {
                    completion(false, error)
                    return
                }

                builder.endCollection(withEnd: rehabilitation.end) { success, error in
                    guard success else {
                        completion(false, error)
                        return
                    }

                    builder.finishWorkout { _, error in
                        guard error == nil else {
                            completion(false, error)
                            return
                        }
                        completion(true, nil)
                    }
                }
            }
        }
    }

    /// Method to fetch all rehabilitations from health data
    func fetchAllRehabilitations(fromDate startDate: Date, completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let startOfDay = Calendar.current.startOfDay(for: startDate)
        let now = Date()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .other)
        let sourcePredicate = HKQuery.predicateForObjects(from: .default())
        let samplesPredicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                           end: now,
                                                           options: [.strictStartDate, .strictEndDate])

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            workoutPredicate,
            sourcePredicate,
            samplesPredicate
        ])

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate,
                                              ascending: true)

        let query = HKSampleQuery(sampleType: .workoutType(),
                                  predicate: compoundPredicate,
                                  limit: 0,
                                  sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard let samples = samples as? [HKWorkout],
                  error == nil else {
                completion(nil, error)
                return
            }

            completion(samples, nil)
        }

        healthStore.execute(query)
    }

    // MARK: - Helper methods

    private func makeRehabQuantitySample(identifier: HKQuantityTypeIdentifier,
                                         rehabilitation: RehabilitationWorkout) -> HKCumulativeQuantitySample? {
        let value: Double

        switch identifier {
        case .activeEnergyBurned:
            value = rehabilitation.totalEnergyBurned
        case .heartRate:
            value = Double(rehabilitation.averageHeartRate)
        default:
#if DEBUG
            print("🆔 There is no value for selected identifier")
#endif
            return nil
        }

        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
#if DEBUG
            print("🔴 There is no valid quantityType")
#endif
            return nil
        }

        guard let unit = HKUnit.preferredUnit(identifier) else {
#if DEBUG
            print("📏 There is no valid unit")
#endif
            return nil
        }

        let quantity = HKQuantity(unit: unit,
                                  doubleValue: value)

        return HKCumulativeQuantitySample(type: quantityType,
                                          quantity: quantity,
                                          start: rehabilitation.start,
                                          end: rehabilitation.end)
    }
}
