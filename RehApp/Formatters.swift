//
//  Formatters.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation

enum Formatters {

    // MARK: - Date formatters

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yMMdd jjmm")
        return formatter
    }()

}
