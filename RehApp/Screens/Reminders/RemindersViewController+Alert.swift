//
//  RemindersViewController+Alert.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation
import UIKit

extension RemindersViewController {

    // MARK: - Create reminder alert

    func configureReminderAlert(type: ReminderAlertType, reminder: ReminderVM? = nil) {
        let alert = makeAlert(type: type, reminder: reminder)
        presentedAlert = alert
        present(alert, animated: true)
    }

    private func makeAlert(type: ReminderAlertType, reminder: ReminderVM?) -> UIAlertController {
        let alert: UIAlertController
        switch type {
        case .newReminder:
            alert = UIAlertController(title: "NewReminder".localize(),
                                      message: "EnterReminderDescription".localize(),
                                      preferredStyle: .alert)
        case .editingReminder:
            alert = UIAlertController(title: "EditReminder".localize(),
                                      message: "EditReminderDescription".localize(),
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
                    $0.placeholder = alertTextField.placehoderName
                    if let reminder = reminder {
                        $0.text = reminder.name
                    }
                }
            case .date:
                alert.addTextField {[weak self] in
                    guard let self = self else { return }
                    $0.delegate = self
                    $0.placeholder = alertTextField.placehoderName
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
            actionTitle = "MakeReminder".localize()
        case .editingReminder:
            actionTitle = "EditReminder".localize()
        }
        let submitAction = UIAlertAction(title: actionTitle,
                                         style: .default,
                                         handler: {[weak self] _ in
            guard let self = self else { return }
            switch type {
            case .newReminder:
                self.createNewReminderAndNotification()
            case .editingReminder:
                self.updateReminderAndNotification(id: reminder?.id)
            }
            self.presentedAlert = nil
        })
        submitAction.isEnabled = false
        self.submitAction = submitAction
        alert.addAction(submitAction)

        alert.addAction(UIAlertAction(title: "Dismiss".localize(),
                                      style: .destructive,
                                      handler: { [weak self] _ in
            self?.presentedAlert = nil
        }))
    }

    // MARK: - Reminder alert helper actions

    func createNewReminderFromAlert(id: UUID) {
        let (name, time) = getNameAndTimeFromAlert()
        guard let name = name,
              let time = time else { return }
        RehAppCache.shared.createReminder(id: id, name: name, time: time)
    }

    func updateReminderFromAlert(id: UUID) {
        let (name, time) = getNameAndTimeFromAlert()
        guard let name = name,
              let time = time else { return }
        RehAppCache.shared.updateReminder(id: id, newName: name, newTime: time)
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
        if textField.placeholder == ReminderAlertTextFields.date.placehoderName {
            if textField.text == "" {
                guard let wheelsTimePicker = wheelsTimePicker else { return }
                let initialTime = Date()
                textField.text = Formatters.timeFormatter.string(from: initialTime)
                wheelsTimePicker.setInitialTime(initialTime)
            }
        }
    }
}
