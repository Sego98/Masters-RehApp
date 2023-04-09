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
        guard let name = name,
              let date = date else { return nil }
        return ReminderVM(name: name, date: date)
    }
}
