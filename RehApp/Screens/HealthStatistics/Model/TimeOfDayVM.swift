//
//  TimeOfDayVM.swift
//  RehApp
//
//  Created by Akademija on 25.04.2023..
//

import Foundation

struct TimeOfDayVM: Identifiable, Hashable, Equatable {

    enum TimeOfDay {
        case morning
        case afternoon

        var name: String {
            switch self {
            case .morning:
                return "Morning".localize()
            case .afternoon:
                return "Afternoon".localize()
            }
        }
    }

    let numberOfTimesExercised: Int
    let timeOfDay: TimeOfDay

    var id: Int { numberOfTimesExercised }

    internal init(numberOfTimesExercised: Int, timeOfDay: TimeOfDayVM.TimeOfDay) {
        self.numberOfTimesExercised = numberOfTimesExercised
        self.timeOfDay = timeOfDay
    }
}
