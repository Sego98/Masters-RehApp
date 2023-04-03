//
//  RehAppTabType.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation

enum RehAppTabType {
    case exercises
    case reminders

    var title: String {
        switch self {
        case .exercises:
            return "Vježbe"
        case .reminders:
            return "Podsjetnici"
        }
    }

    var unselectedSystemImageName: String {
        switch self {
        case .exercises:
            return "figure.run.square.stack"
        case .reminders:
            return "clock"
        }
    }

    var selectedSystemImageName: String {
        switch self {
        case .exercises:
            return "figure.run.square.stack.fill"
        case .reminders:
            return "clock.fill"
        }
    }
}
