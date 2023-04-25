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
    var heartRates: [HeartRateVM]
    let sevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -6), to: Date())

    var averageHeartRate: Double {
        return Double(heartRates.reduce(0) { $0 + $1.value } / heartRates.count)
    }

    var minHeartRateYValue: Int {
        let minHeartRate = heartRates.min {
            $0.value < $1.value
        }?.value
        guard let minHeartRate = minHeartRate else { return 0 }
        return minHeartRate - 30
    }

    var maxHeartRateYValue: Int {
        let maxHeartRate = heartRates.min {
            $0.value > $1.value
        }?.value
        guard let maxHeartRate = maxHeartRate else { return 0 }
        return maxHeartRate + 30
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            GraphHeaderView(title: "Otkucaji srca", averageValue: averageHeartRate, unit: "o/min")
            Chart {
                ForEach(heartRates) { heartRate in
                    LineMark(
                        x: .value("Day", heartRate.dayBegin, unit: .day),
                        y: .value("Heart rate", heartRate.value)
                    )
                    .foregroundStyle(Color.burgundy)
                    PointMark(
                        x: .value("Day", heartRate.dayBegin, unit: .day),
                        y: .value("Heart rate", heartRate.value)
                    )
                    .foregroundStyle(Color.teal)
                }
                .interpolationMethod(.catmullRom)
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYAxisLabel(position: .leading, alignment: .leadingLastTextBaseline, spacing: 8) {
                Text("o/min")
                    .font(.footnote)
            }
            .chartYScale(domain: minHeartRateYValue...maxHeartRateYValue)
        })
    }
}
