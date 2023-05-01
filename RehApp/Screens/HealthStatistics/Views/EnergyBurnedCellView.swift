//
//  EnergyBurnedCellView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 25.04.2023..
//

import Foundation
import SwiftUI
import Charts

struct EnergyBurnedCellView: View {
    var energiesBurned: [EnergyBurnedVM]

    var averageEnergyBurned: Double {
        let elementsWithValues = energiesBurned.filter({ $0.value > 0 })
        return energiesBurned.reduce(0.0) { $0 + $1.value } / Double(elementsWithValues.count)
    }

    var maxHeartRateYValue: Double {
        let energyBurnedValues = energiesBurned.map { $0.value }
        let maxValue = energyBurnedValues.max()
        guard let maxValue = maxValue else { return 0.0 }
        return maxValue + 50.0
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            GraphHeaderView(title: "EnergyBurned".localize(), averageValue: averageEnergyBurned, unit: "kcal")
            Chart {
                ForEach(energiesBurned) { energyBurned in
                    BarMark(
                        x: .value("Day", energyBurned.dayBegin, unit: .day),
                        y: .value("Energy burned", energyBurned.value)
                    )
                    .foregroundStyle(Color.blue)
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYAxisLabel(position: .leading, alignment: .leadingFirstTextBaseline, spacing: 8) {
                Text("kcal")
                    .font(.footnote)
            }
            .chartYScale(domain: 0...maxHeartRateYValue)
        })
    }
}
