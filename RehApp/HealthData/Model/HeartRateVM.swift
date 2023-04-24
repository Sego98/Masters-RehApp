//
//  HeartRateVM.swift
//  RehApp
//
//  Created by Akademija on 23.04.2023..
//

import Foundation

struct HeartRateVM: Identifiable, Hashable, Equatable {
    let value: Int
    let id: UUID

    var name: String { id.uuidString }

    internal init(value: Int, id: UUID = UUID()) {
        self.value = value
        self.id = id
    }
}
