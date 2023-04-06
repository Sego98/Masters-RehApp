//
//  ReminderAlertConfiguration.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation

enum AlertTextFields: String, CaseIterable {
    case name = "Unesi naslov"
    case date = "Unesi datum"
}

enum AlertType {
    case newReminder
    case editingReminder
}
