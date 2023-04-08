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

    func configureReminderAlert(type: ReminderAlertType, reminder: CDReminder? = nil) {
        let alert = makeAlert(type: type, reminder: reminder)
        presentedAlert = alert
        present(alert, animated: true)
    }

    private func makeAlert(type: ReminderAlertType, reminder: CDReminder?) -> UIAlertController {
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
                                      reminder: CDReminder?) {
        let datePicker: WheelsTimePicker?
        switch type {
        case .newReminder:
            datePicker = WheelsTimePicker(identifier: "datePicker", initialDate: Date())
        case .editingReminder:
            guard let reminder = reminder,
                  let date = reminder.date else { return }
            datePicker = WheelsTimePicker(identifier: "datePicker", initialDate: date)
        }
        datePicker?.delegate = self

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
                    $0.inputView = datePicker
                    if let reminder = reminder,
                       let date = reminder.date {
                        $0.text = Formatters.timeFormatter.string(from: date)
                    }
                }
            }
        }
    }

    private func makeAlertActions(_ alert: UIAlertController,
                                  type: ReminderAlertType,
                                  reminder: CDReminder?) {
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
                self.createNewReminderFromAlert()
            case .editingReminder:
                if let reminder = reminder {
                    self.updateReminderFromAlert(reminder: reminder)
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

    private func createNewReminderFromAlert() {
        let (name, date) = getNameAndDateFromAlert()
        guard let name = name,
              let date = date else { return }
        createReminder(name: name, date: date)
    }

    private func updateReminderFromAlert(reminder: CDReminder) {
        let (name, date) = getNameAndDateFromAlert()
        guard let name = name,
              let date = date else { return }
        updateReminder(reminder, newName: name, newDate: date)
    }

    private func getNameAndDateFromAlert() -> (String?, Date?) {
        guard let alert = presentedAlert,
              let textFields = alert.textFields else { return (nil, nil) }
        let textFieldTexts = textFields.map { $0.text }
        guard let name = textFieldTexts[0],
              let dateString = textFieldTexts[1],
              let date = Formatters.timeFormatter.date(from: dateString) else { return (nil, nil) }
        return (name, date)
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
                textField.text = Formatters.timeFormatter.string(from: Date())
            }
        }
    }
}
