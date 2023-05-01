//
//  RehAppTabType.swift
//  RehApp
//
//  Created by Petar Ljubotina on 03.04.2023..
//

import Foundation

enum RehAppTabType {
    case exercises
    case reminders
    case statistics

    var title: String {
        switch self {
        case .exercises:
            return "Exercises".localize()
        case .reminders:
            return "Reminders".localize()
        case .statistics:
            return "Statistics".localize()
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
