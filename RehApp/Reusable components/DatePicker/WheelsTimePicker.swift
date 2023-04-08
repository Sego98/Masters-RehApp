//
//  WheelsDatePicker.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation
import UIKit

final class WheelsTimePicker: UIDatePicker {

    // MARK: - Properties

    private var identifier: String
    private var reminderSetTime: Date?
    weak var delegate: DateInputDelegate?

    // MARK: - Init

    init(identifier: String, reminderSetTime: Date? = nil) {
        self.identifier = identifier
        self.reminderSetTime = reminderSetTime
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        if let reminderSetTime = reminderSetTime {
            date = reminderSetTime
        }
        preferredDatePickerStyle = .wheels
        datePickerMode = .time

        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.datePicker(self.identifier,
                                      didSelectDate: self.date)
        }

        addAction(action, for: .valueChanged)
    }

    // MARK: - Public methods

    func setInitialTime(_ initialTime: Date) {
        date = initialTime
    }
}
