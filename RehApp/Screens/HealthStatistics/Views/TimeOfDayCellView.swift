//
//  TimeOfDayCellView.swift
//  RehApp
//
//  Created by Akademija on 25.04.2023..
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
            return "Bravo, više ti paše jutro za treniranje. Tada je najbolje trenirati jer imaš najviše energije"
        } else if morningExercises < afternoonExercises {
            return """
            Više voliš vježbati poslije podne. Pokušaj se ustati ranije i odraditi rehabilitaciju kada imaš više \
            enerije,  vidjet ćeš da ćeš se bolje osjećati.
            """
        } else {
            return """
            Tebi je potpuno svejedno u koje doba dana vježbaš. Svejedno, pokušaj više trenirati ujutro jer tada \
            imaš najviše energije.
            """
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("🌗 Vrijeme dana rehabilitacije")
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
                        x: .value("Time of day", timeOfDayVM.timeOfDay.rawValue),
                        y: .value("Quantity", timeOfDayVM.numberOfTimesExercised)
                    )
                    .foregroundStyle(Color.lightPurple)
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
