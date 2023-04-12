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

    static let massFormatter: MassFormatter = {
        let formatter = MassFormatter()
        formatter.isForPersonMassUse = true
        return formatter
    }()

    static let heightFormatter: LengthFormatter = {
        let formatter = LengthFormatter()
        formatter.isForPersonHeightUse = true
        return formatter
    }()
}
