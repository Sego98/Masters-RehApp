//
//  HealthData+Workout.swift
//  RehApp
//
//  Created by Akademija on 18.04.2023..
//

import Foundation
import HealthKit

extension HealthData {

    func saveWorkout(_ rehabilitation: RehabilitationWorkout,
                     completion: @escaping (Bool, Error?) -> Void) {
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .other

        let builder = HKWorkoutBuilder(healthStore: healthStore,
                                       configuration: workoutConfiguration,
                                       device: .local())

        builder.beginCollection(withStart: rehabilitation.start) { success, error in
            guard success else {
                completion(false, error)
                return
            }

            guard let quantityType = HKQuantityType.quantityType(
              forIdentifier: .activeEnergyBurned) else {
              completion(false, nil)
              return
            }

            let unit = HKUnit.kilocalorie()
            let totalEnergyBurned = rehabilitation.totalEnergyBurned
            let quantity = HKQuantity(unit: unit,
                                      doubleValue: totalEnergyBurned)

            let sample = HKCumulativeQuantitySample(type: quantityType,
                                                    quantity: quantity,
                                                    start: rehabilitation.start,
                                                    end: rehabilitation.end)

            builder.add([sample]) { success, error in
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
}
