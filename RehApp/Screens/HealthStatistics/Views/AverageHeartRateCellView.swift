//
//  AverageHeartRateCellView.swift
//  RehApp
//
//  Created by Akademija on 23.04.2023..
//

import Foundation
import SwiftUI
import Charts

struct AverageHeartRateCellView: View {
    var heartRates: [HeartRate]

    var averageHeartRate: Int {
        return heartRates.reduce(0) { $0 + $1.value } / heartRates.count
    }

    var body: some View {
        VStack {
            HStack {
                Text("Prosječna vrijednost:")
                    .foregroundStyle(.primary)
                    .font(.title3)
                Spacer()
                Text("\(averageHeartRate)")
                    .foregroundStyle(.secondary)
                    .font(.body)
            }
            Chart {
                ForEach(heartRates) { heartRate in
                    LineMark(
                        x: .value("Name", heartRate.name),
                        y: .value("Heart rate", heartRate.value)
                    )
                    .foregroundStyle(Color.burgundy)
                }
            }
            .chartYAxisLabel(position: .trailing, alignment: .leading, spacing: 8) {
                Text("BPM")
                    .font(.footnote)
            }
        }
    }
}
