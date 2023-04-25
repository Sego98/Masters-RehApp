//
//  HealthStatisticsViewController+HealthProperties.swift
//  RehApp
//
//  Created by Akademija on 12.04.2023..
//

import Foundation
import UIKit
import HealthKit

extension HealthStatisticsViewController {

    func fetchAllRehabilitationWorkouts(from date: Date) {
        HealthData.shared.fetchAllRehabilitations(fromDate: date) { [weak self] (rehabilitations, error) in
            guard let self = self,
                  let rehabilitations = rehabilitations,
                  error == nil else {
#if DEBUG
                print("❌ Rehabilitations failed to fetch with error \(error?.localizedDescription ?? "")")
#endif
                return
            }
            let rehabilitationVMs = rehabilitations.map({ RehabilitationWorkout(start: $0.startDate, end: $0.endDate)})
            let durations = rehabilitationVMs.map({ WorkoutDurationVM(valueMinutes: $0.duration / 60,
                                                                      dayBegin: $0.start)})
            self.durations = durations
            configureChartsIfPossible()
        }
    }

    func fetchAverageQuantitiesForRehabilitations(identifier: HKQuantityTypeIdentifier,
                                                  from date: Date) {
        HealthData.shared.fetchDailyStatistics(identifier: identifier,
                                               from: date) {  (statisticsCollection, error) in
            guard error == nil else {
#if DEBUG
                print("❌ Quantities for rehabilitations failed to fetch with error \(error!.localizedDescription)")
#endif
                return
            }

            guard let unit = HKUnit.preferredUnit(identifier) else {
#if DEBUG
                print("❌ There is no defined unit for the identifier \(identifier)")
#endif
                return
            }

            statisticsCollection?.enumerateStatistics(from: date, to: Date(), with: { [weak self] (statistics, _) in
                guard let self = self else { return }
                switch identifier {
                case .heartRate:
                    if let value = statistics.averageQuantity()?.doubleValue(for: unit) {
                        averageHeartRates.append(HeartRateVM(value: Int(value), dayBegin: statistics.startDate))
                    }
                case .activeEnergyBurned:
                    if let value = statistics.sumQuantity()?.doubleValue(for: unit) {
                        energiesBurned.append(EnergyBurnedVM(value: value, dayBegin: statistics.startDate))
                    }
                default:
                    return
                }
                configureChartsIfPossible()
            })
        }
    }

    // MARK: - Helper methods

//    private func getQuantityValueFromHealth(for identifier: HKQuantityTypeIdentifier,
//                                            completion: @escaping (Double?) -> Void) {
//        HealthData.shared.fetchMostRecentQuantitySample(for: identifier) { height, error in
//            DispatchQueue.main.async {
//                if let error = error {
// #if DEBUG
//                    print("No quantity value, \(error.localizedDescription)")
// #endif
//                    completion(nil)
//                }
//                completion(height)
//            }
//        }
//    }
}
