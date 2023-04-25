//
//  EnergyBurnedVM.swift
//  RehApp
//
//  Created by Akademija on 24.04.2023..
//

import Foundation

struct EnergyBurnedVM: Identifiable, Hashable, Equatable {
    let value: Double
    let dayBegin: Date
//    let id: UUID

    var id: Double { value }

    internal init(value: Double, dayBegin: Date) {
        self.value = value
        self.dayBegin = dayBegin
//        self.id = id
    }
}
