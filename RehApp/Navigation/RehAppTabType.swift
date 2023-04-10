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
    case statistics

    var title: String {
        switch self {
        case .exercises:
            return "Vježbe"
        case .reminders:
            return "Podsjetnici"
        case .statistics:
            return "Statistika"
        }
    }

    var unselectedSystemImageName: String {
        switch self {
        case .exercises:
            return "figure.run.square.stack"
        case .reminders:
            return "clock"
        case .statistics:
            return "chart.bar.xaxis"
        }
    }

    var selectedSystemImageName: String {
        switch self {
        case .exercises:
            return "figure.run.square.stack.fill"
        case .reminders:
            return "clock.fill"
        case .statistics:
            return "chart.bar.xaxis"
        }
    }
}
