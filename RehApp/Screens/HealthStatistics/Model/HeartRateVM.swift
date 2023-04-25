//
//  HeartRateVM.swift
//  RehApp
//
//  Created by Akademija on 23.04.2023..
//

import Foundation

struct HeartRateVM: Identifiable, Hashable, Equatable {
    let value: Int
    let dayBegin: Date
//    let id: UUID

    var id: Int { value }

    internal init(value: Int, dayBegin: Date) {
        self.value = value
        self.dayBegin = dayBegin
//        self.id = id
    }
}
