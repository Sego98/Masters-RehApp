//
//  ReminderAlertConfiguration.swift
//  RehApp
//
//  Created by Petar Ljubotina on 06.04.2023..
//

import Foundation

enum ReminderAlertTextFields: CaseIterable {
    case name
    case date

    var placehoderName: String {
        switch self {
        case .name:
            return "EnterTitle".localize()
        case .date:
            return "EnterDate".localize()
        }
    }
}

enum ReminderAlertType {
    case newReminder
    case editingReminder
}
