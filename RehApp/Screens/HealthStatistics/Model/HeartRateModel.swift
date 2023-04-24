//
//  HeartRateModel.swift
//  RehApp
//
//  Created by Akademija on 23.04.2023..
//

import Foundation

struct HeartRate: Identifiable, Hashable, Equatable {
    let value: Int

    var name: String { String(value) }
    var id: UUID { UUID() }
}
