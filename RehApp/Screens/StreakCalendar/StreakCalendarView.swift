//
//  StreakCalendarView.swift
//  RehApp
//
//  Created by Akademija on 30.03.2023..
//

import Foundation
import UIKit

final class StreakCalendarView: UIView {

    // MARK: - Proeprties

    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .rehAppBackground
        calendarView.tintColor = .darkPurple
        calendarView.fontDesign = .rounded
        return calendarView
    }()

    private let allDaysLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()

    private let testDates = [
        DateComponents(year: 2023, month: 3, day: 3),
        DateComponents(year: 2023, month: 4, day: 1),
        DateComponents(year: 2023, month: 4, day: 2)
    ]

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .rehAppBackground

        guard let firstDate = Calendar.current.date(from: testDates[0]) else { return }
        let startDateComponents = Calendar.current.dateComponents([.month, .year], from: firstDate)
        guard let startDate = Calendar.current.date(from: startDateComponents) else { return }

        calendarView.availableDateRange = DateInterval(start: startDate,
                                                       end: Date())

        addSubviews([
            calendarView, allDaysLabel
        ])

        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        dateSelection.selectedDates = testDates
        calendarView.selectionBehavior = dateSelection

        allDaysLabel.text = "Ukupan broj odrađenih dana: \(testDates.count)"

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let guide = layoutMarginsGuide

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: guide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            allDaysLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            allDaysLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            allDaysLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            allDaysLabel.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
        ])
    }
}

extension StreakCalendarView: UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        selection.selectedDates = testDates
    }

    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        selection.selectedDates = testDates
    }
}
