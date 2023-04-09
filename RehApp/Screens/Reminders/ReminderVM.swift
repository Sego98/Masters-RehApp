//
//  ReminderVM.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation

struct ReminderVM: Hashable, Equatable {
    let id: UUID
    let name: String
    let time: Date
    let isRepeating: Bool
}
