//
//  AverageEnergyBurnedVM.swift
//  RehApp
//
//  Created by Akademija on 24.04.2023..
//

import Foundation

struct AverageEnergyBurnedVM: Identifiable, Hashable, Equatable {
    let value: Double
    let id: UUID

    var name: String { id.uuidString }

    internal init(value: Double, id: UUID = UUID()) {
        self.value = value
        self.id = id
    }
}
