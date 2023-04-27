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
                self?.didFetchRehabilitationWorkouts = true
                return
            }
            makeViewModels(from: rehabilitations, startDate: date)
            didFetchRehabilitationWorkouts = true
            configureChartsIfPossible()
        }
    }

    func fetchAverageQuantitiesForRehabilitations(identifier: HKQuantityTypeIdentifier,
                                                  from date: Date) {
        HealthData.shared.fetchDailyStatistics(identifier: identifier,
                                               from: date) { [weak self] (statisticsCollection, error) in
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

            guard let self = self,
                  let numberOfElements = makeNumberOfElements(from: statisticsCollection,
                                                              identifier: identifier) else {
                return
            }

            guard numberOfElements > 0 else {
                switch identifier {
                case .heartRate:
                    didFetchAverageHeartRates = true
                case .activeEnergyBurned:
                    didFetchEnergiesBurned = true
                default:
                    return
                }
                configureChartsIfPossible()
                return
            }

            statisticsCollection?.enumerateStatistics(from: date, to: Date(), with: { (statistics, _) in
                switch identifier {
                case .heartRate:
                    if let value = statistics.averageQuantity()?.doubleValue(for: unit) {
                        self.averageHeartRates.append(HeartRateVM(value: Int(value), dayBegin: statistics.startDate))
                    }

                    if self.averageHeartRates.count == numberOfElements {
                        self.didFetchAverageHeartRates = true
                    }

                case .activeEnergyBurned:
                    if let value = statistics.sumQuantity()?.doubleValue(for: unit) {
                        self.energiesBurned.append(EnergyBurnedVM(value: value, dayBegin: statistics.startDate))
                    } else {
                        self.energiesBurned.append(EnergyBurnedVM(value: 0.0, dayBegin: statistics.startDate))
                    }

                    if self.energiesBurned.count == numberOfElements {
                        self.didFetchEnergiesBurned = true
                    }

                default:
                    return
                }
                self.configureChartsIfPossible()
            })
        }
    }

    // MARK: - Helper methods

    private func makeNumberOfElements(from statisticsCollection: HKStatisticsCollection?,
                                      identifier: HKQuantityTypeIdentifier) -> Int? {
        guard let statisticsCollection = statisticsCollection else { return nil }
        switch identifier {
        case .heartRate:
            return statisticsCollection.statistics().compactMap({ $0.averageQuantity() }).count
        case .activeEnergyBurned:
            return statisticsCollection.statistics().map({ $0.sumQuantity() }).count
        default:
            return nil
        }
    }

    private func makeViewModels(from rehabilitations: [HKWorkout], startDate: Date) {
        let rehabilitationVMs = rehabilitations.map({ RehabilitationWorkout(start: $0.startDate, end: $0.endDate)})
        var rehabDurations = rehabilitationVMs.map({ WorkoutDurationVM(valueMinutes: $0.duration / 60,
                                                                  dayBegin: $0.start)})
        let now = Date()
        let rehabStartDateComponents = rehabDurations.map({ Calendar.current.dateComponents([.year, .month, .day],
                                                                                            from: $0.dayBegin)
        })
        var date = startDate

        while date < now {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            if rehabStartDateComponents.contains(dateComponents) == false {
                rehabDurations.append(WorkoutDurationVM(valueMinutes: 0.0, dayBegin: date))
            }
            date = Calendar.current.date(byAdding: DateComponents(day: 1), to: date)!
        }

        var morningExercises = 0
        var afternoonExercises = 0
        for rehabilitationVM in rehabilitationVMs {
            if Calendar.current.component(.hour, from: rehabilitationVM.start) < 12 {
                morningExercises += 1
            } else {
                afternoonExercises += 1
            }
        }

        self.rehabilitations = rehabilitationVMs

        durations = rehabDurations.sorted(by: {
            $0.dayBegin < $1.dayBegin
        })

        timesOfDay = [
            TimeOfDayVM(numberOfTimesExercised: morningExercises, timeOfDay: .morning),
            TimeOfDayVM(numberOfTimesExercised: afternoonExercises, timeOfDay: .afternoon)
        ]
    }
}
