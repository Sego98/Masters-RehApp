//
//  Formatters.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation

enum Formatters {

    // MARK: - Time formatters

    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("jjmm")
        return formatter
    }()

}
