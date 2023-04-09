//
//  RemindersViewController+Alert.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation
import UIKit

extension RemindersViewController {

    // MARK: - Reminder alert

    func configureReminderAlert(type: ReminderAlertType, reminder: ReminderVM? = nil) {
        let alert = makeAlert(type: type, reminder: reminder)
        presentedAlert = alert
        present(alert, animated: true)
    }

    private func makeAlert(type: ReminderAlertType, reminder: ReminderVM?) -> UIAlertController {
        let alert: UIAlertController
        switch type {
        case .newReminder:
            alert = UIAlertController(title: "Novi podsjetnik",
                                      message: "Za unos novog podsjetnika unesi ime i vrijeme",
                                      preferredStyle: .alert)
        case .editingReminder:
            alert = UIAlertController(title: "Uredi podsjetnik",
                                      message: "Za uređivanje podsjetnika unesite novo ime i vrijeme",
                                      preferredStyle: .alert)
        }
        makeAlertInputFields(alert, type: type, reminder: reminder)
        makeAlertActions(alert, type: type, reminder: reminder)
        return alert
    }

    private func makeAlertInputFields(_ alert: UIAlertController,
                                      type: ReminderAlertType,
                                      reminder: ReminderVM?) {
        switch type {
        case .newReminder:
            wheelsTimePicker = WheelsTimePicker(identifier: "datePicker")
        case .editingReminder:
            guard let reminder = reminder else { return }
            wheelsTimePicker = WheelsTimePicker(identifier: "datePicker", reminderSetTime: reminder.time)
        }
        wheelsTimePicker?.delegate = self

        for alertTextField in ReminderAlertTextFields.allCases {
            switch alertTextField {
            case .name:
                alert.addTextField {[weak self] in
                    guard let self = self else { return }
                    $0.delegate = self
                    $0.placeholder = alertTextField.rawValue
                    if let reminder = reminder {
                        $0.text = reminder.name
                    }
                }
            case .date:
                alert.addTextField {[weak self] in
                    guard let self = self else { return }
                    $0.delegate = self
                    $0.placeholder = alertTextField.rawValue
                    $0.inputView = self.wheelsTimePicker
                    if let reminder = reminder {
                        $0.text = Formatters.timeFormatter.string(from: reminder.time)
                    }
                }
            }
        }
    }

    private func makeAlertActions(_ alert: UIAlertController,
                                  type: ReminderAlertType,
                                  reminder: ReminderVM?) {
        let actionTitle: String
        switch type {
        case .newReminder:
            actionTitle = "Napravi podsjetnik"
        case .editingReminder:
            actionTitle = "Uredi podsjetnik"
        }
        let submitAction = UIAlertAction(title: actionTitle,
                                         style: .default,
                                         handler: {[weak self] _ in
            guard let self = self else { return }
            switch type {
            case .newReminder:
                let id = UUID()
                self.createNewReminderFromAlert(id: id)
                self.scheduleReminderNotification(with: id)
            case .editingReminder:
                if let reminder = reminder {
                    self.updateReminderFromAlert(reminder: reminder)
                    self.scheduleReminderNotification(with: reminder.id)
                }
            }
            self.presentedAlert = nil
            self.dismiss(animated: true)
        })
        submitAction.isEnabled = false
        self.submitAction = submitAction
        alert.addAction(submitAction)

        alert.addAction(UIAlertAction(title: "Odustani",
                                      style: .destructive,
                                      handler: { [weak self] _ in
            self?.presentedAlert = nil
            self?.dismiss(animated: true)
        }))
    }

    private func createNewReminderFromAlert(id: UUID) {
        let (name, time) = getNameAndTimeFromAlert()
        guard let name = name,
              let time = time else { return }
        createReminder(name: name, time: time, id: id)
    }

    private func updateReminderFromAlert(reminder: ReminderVM) {
        let (name, time) = getNameAndTimeFromAlert()
        guard let name = name,
              let time = time else { return }
        updateReminder(id: reminder.id, newName: name, newTime: time, rebuildSnapshot: true)
    }

    private func getNameAndTimeFromAlert() -> (String?, Date?) {
        guard let alert = presentedAlert,
              let textFields = alert.textFields else { return (nil, nil) }
        let textFieldTexts = textFields.map { $0.text }
        guard let name = textFieldTexts[0],
              let timeString = textFieldTexts[1],
              let time = Formatters.timeFormatter.date(from: timeString) else { return (nil, nil) }
        return (name, time)
    }

    private func enableSubmitButtonIfNeeded() {
        guard let alert = presentedAlert,
              let textFields = alert.textFields,
              let submitAction = submitAction else { return }
        var shouldEnableSubmitButton = true
        for textField in textFields where textField.text == "" {
            shouldEnableSubmitButton = false
        }
        submitAction.isEnabled = shouldEnableSubmitButton
    }
}

extension RemindersViewController: DateInputDelegate {

    func datePicker(_ identifier: String, didSelectDate date: Date?) {
        if identifier == "datePicker" {
            guard let date = date,
                  let alert = presentedAlert else { return }
            alert.textFields?[1].text = Formatters.timeFormatter.string(from: date)
        }
    }

}

extension RemindersViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        enableSubmitButtonIfNeeded()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.placeholder == ReminderAlertTextFields.date.rawValue {
            if textField.text == "" {
                guard let wheelsTimePicker = wheelsTimePicker else { return }
                let initialTime = Date()
                textField.text = Formatters.timeFormatter.string(from: initialTime)
                wheelsTimePicker.setInitialTime(initialTime)
            }
        }
    }
}
