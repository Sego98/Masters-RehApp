//
//  TimeOfDayCellView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 25.04.2023..
//

import Foundation
import SwiftUI
import Charts

struct TimeOfDayCellView: View {
    var timesOfDay: [TimeOfDayVM]

    var description: String {
        var morningExercises = 0
        var afternoonExercises = 0
        for day in timesOfDay {
            if day.timeOfDay == .morning {
                morningExercises += day.numberOfTimesExercised
            } else if day.timeOfDay == .afternoon {
                afternoonExercises += day.numberOfTimesExercised
            }
        }
        if morningExercises > afternoonExercises {
            return "ExerciseInMorning".localize()
        } else if morningExercises < afternoonExercises {
            return "ExerciseInAfternoon".localize()
        } else {
            return "ExerciseAnyTime".localize()
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("TimeOfDay".localize())
                .foregroundColor(.primary)
                .font(.title2)
                .fontWeight(.bold)
            Text(description)
                .foregroundColor(.primary)
                .font(.body)
            Spacer()
            Chart {
                ForEach(timesOfDay) { timeOfDayVM in
                    BarMark(
                        x: .value("Time of day", timeOfDayVM.timeOfDay.name),
                        y: .value("Quantity", timeOfDayVM.numberOfTimesExercised)
                    )
                    .foregroundStyle(Color.orange)
                }
            }
            .chartXAxis {
                AxisMarks {
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
    }
}
