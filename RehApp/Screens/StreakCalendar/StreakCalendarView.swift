//
//  StreakCalendarView.swift
//  RehApp
//
//  Created by Akademija on 30.03.2023..
//

import Foundation
import UIKit

final class StreakCalendarView: UIView {

    // MARK: - Properties

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
        label.font = .preferredFont(for: .title2, weight: .bold)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()

    private var calendarDateComponents = [DateComponents]()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        fetchAllCalendarDates()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .rehAppBackground

        var firstMonthDateComponents: DateComponents
        if calendarDateComponents.isEmpty == false {
            firstMonthDateComponents = calendarDateComponents[0]
            firstMonthDateComponents.day = nil
        } else {
            firstMonthDateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        }

        guard let firstMonth = Calendar.current.date(from: firstMonthDateComponents) else { return }

        calendarView.availableDateRange = DateInterval(start: firstMonth,
                                                       end: Date())

        addSubviews([
            calendarView, allDaysLabel
        ])

        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        dateSelection.selectedDates = calendarDateComponents
        calendarView.selectionBehavior = dateSelection

        allDaysLabel.text = "🔥 Ukupan broj dana: \(calendarDateComponents.count)"

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

    private func fetchAllCalendarDates() {
        guard let coreDataCalendarDates = RehAppCache.shared.getAllCalendarItems() else {
            return
        }
        let calendarDates = coreDataCalendarDates.compactMap({ $0.date }).sorted {
            $0 < $1
        }

        calendarDateComponents = calendarDates.map({ Calendar.current.dateComponents([.year, .month, .day],
                                                                                     from: $0) })
    }

}

extension StreakCalendarView: UICalendarSelectionMultiDateDelegate {

    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        selection.selectedDates = calendarDateComponents
    }

    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        selection.selectedDates = calendarDateComponents
    }
}
