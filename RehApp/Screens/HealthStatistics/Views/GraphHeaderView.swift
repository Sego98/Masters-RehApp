//
//  GraphHeaderView.swift
//  RehApp
//
//  Created by Akademija on 24.04.2023..
//

import Foundation
import SwiftUI

struct GraphHeaderView: View {
    let title: String
    let averageValue: Double
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.primary)
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                Text("Prosječna vrijednost:")
                    .foregroundStyle(.primary)
                    .font(.title3)
                Spacer()
                Text("\(Formatters.doubleFormatter.string(from: NSNumber(value: averageValue)) ?? "") \(unit)")
                    .foregroundStyle(.secondary)
                    .font(.body)
                    .fontWeight(.bold)
            }
        }
    }
}
