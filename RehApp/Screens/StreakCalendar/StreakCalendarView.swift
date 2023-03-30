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
        return calendarView
    }()

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

        addSubview(calendarView)

        directionalLayoutMargins = .zero
        let guide = layoutMarginsGuide

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: guide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            calendarView.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
        ])
    }
}
