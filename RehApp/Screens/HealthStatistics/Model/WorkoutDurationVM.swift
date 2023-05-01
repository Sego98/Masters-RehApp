//
//  WorkoutDurationVM.swift
//  RehApp
//
//  Created by Petar Ljubotina on 25.04.2023..
//

import Foundation

struct WorkoutDurationVM: Identifiable, Hashable, Equatable {
    let valueMinutes: Double
    let dayBegin: Date

    var id: Double { valueMinutes }

    internal init(valueMinutes: Double, dayBegin: Date) {
        self.valueMinutes = valueMinutes
        self.dayBegin = dayBegin
    }
}
