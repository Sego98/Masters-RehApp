//
//  ReminderAlertConfiguration.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation

enum ReminderAlertTextFields: String, CaseIterable {
    case name = "Unesi naslov"
    case date = "Unesi datum"
}

enum ReminderAlertType {
    case newReminder
    case editingReminder
}
