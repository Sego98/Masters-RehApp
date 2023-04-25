//
//  WorkoutDurationVM.swift
//  RehApp
//
//  Created by Akademija on 25.04.2023..
//

import Foundation

struct WorkoutDurationVM: Identifiable, Hashable, Equatable {
    let valueMinutes: Double
    let dayBegin: Date
    let id: UUID

    internal init(valueMinutes: Double, dayBegin: Date, id: UUID = UUID()) {
        self.valueMinutes = valueMinutes
        self.dayBegin = dayBegin
        self.id = id
    }
}
