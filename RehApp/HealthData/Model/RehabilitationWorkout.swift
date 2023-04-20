//
//  RehabilitationWorkout.swift
//  RehApp
//
//  Created by Akademija on 18.04.2023..
//

import Foundation

struct RehabilitationWorkout {
    let start: Date
    let end: Date

    // MARK: - Computed properties

    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }

    var totalEnergyBurned: Double {
        let rehabilitationCaloriesPerHour: Double = 450
        let hours: Double = duration / 3600
        let totalCalories = hours * rehabilitationCaloriesPerHour
        return totalCalories
    }

    var averageHeartRate: Int {
        return Int.random(in: 105...125)
    }

    // MARK: - Test workouts

    static let workout1: RehabilitationWorkout = {
        let startDate = DateComponents(year: 2023, month: 4, day: 19, hour: 20, minute: 5, second: 0)
        let endDate = DateComponents(year: 2023, month: 4, day: 19, hour: 20, minute: 55, second: 48)
        return RehabilitationWorkout(start: Calendar.current.date(from: startDate)!,
                                     end: Calendar.current.date(from: endDate)!)
    }()
}
