//
//  DurationCellView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 25.04.2023..
//

import Foundation
import SwiftUI
import Charts

struct DurationCellView: View {
    var durations: [WorkoutDurationVM]

    var averageDuration: Double {
        let elementsWithValues = durations.filter({ $0.valueMinutes > 0 })
        return durations.reduce(0.0) { $0 + $1.valueMinutes } / Double(elementsWithValues.count)
    }

    var maxDurationYValue: Double {
        let durationValues = durations.map { $0.valueMinutes }
        let maxDuration = durationValues.max()
        guard let maxDuration = maxDuration else { return 0.0 }
        return maxDuration + 30
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            GraphHeaderView(title: "DurationInMin".localize(), averageValue: averageDuration, unit: "min")
            Chart {
                ForEach(durations) { duration in
                    LineMark(
                        x: .value("Day", duration.dayBegin, unit: .day),
                        y: .value("Duration", duration.valueMinutes)
                    )
                    .foregroundStyle(Color.burgundy)
                    PointMark(
                        x: .value("Day", duration.dayBegin, unit: .day),
                        y: .value("Duration", duration.valueMinutes)
                    )
                    .foregroundStyle(Color.orange)
                }
                .interpolationMethod(.cardinal)
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
                Text("min")
                    .font(.footnote)
            }
            .chartYScale(domain: 0...maxDurationYValue)
        })
    }
}
