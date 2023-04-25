//
//  TimeOfDayVM.swift
//  RehApp
//
//  Created by Akademija on 25.04.2023..
//

import Foundation

struct TimeOfDayVM: Identifiable, Hashable, Equatable {

    enum TimeOfDay: String {
        case morning = "Prijepodne"
        case afternoon = "Poslijepodne"
    }

    let numberOfTimesExercised: Int
    let timeOfDay: TimeOfDay
//    let id: UUID

    var id: Int { numberOfTimesExercised }

    internal init(numberOfTimesExercised: Int, timeOfDay: TimeOfDayVM.TimeOfDay) {
        self.numberOfTimesExercised = numberOfTimesExercised
        self.timeOfDay = timeOfDay
//        self.id = id
    }
}
