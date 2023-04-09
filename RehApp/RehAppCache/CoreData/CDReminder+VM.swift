//
//  CDReminder+VM.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation
import CoreData

extension CDReminder {

    var viewModel: ReminderVM? {
        guard let id = id,
              let name = name,
              let time = time else { return nil }
        return ReminderVM(id: id, name: name, time: time, isRepeating: isRepeating)
    }
}
