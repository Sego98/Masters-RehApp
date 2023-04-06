//
//  RemindersViewController+Alert.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation
import UIKit

extension RemindersViewController {

    // MARK: - New reminder alert

    func configureReminderAlert(type: AlertType, reminder: CDReminder? = nil) {
        let alert = makeAlert(type: type, reminder: reminder)
        presentedAlert = alert
        present(alert, animated: true)
    }

    private func makeAlert(type: AlertType, reminder: CDReminder?) -> UIAlertController {
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
        let alertWithInputFields = makeAlertInputFields(alert, type: type, reminder: reminder)
        let alertWithActions = makeAlertActions(alert, type: type, reminder: reminder)
        return alertWithActions
    }

    private func makeAlertInputFields(_ alert: UIAlertController,
                                      type: AlertType,
                                      reminder: CDReminder?) -> UIAlertController {
        let datePicker: WheelsDatePicker?
        switch type {
        case .newReminder:
            datePicker = WheelsDatePicker(identifier: "datePicker", initialDate: Date())
        case .editingReminder:
            if let reminder = reminder,
               let date = reminder.date {
                datePicker = WheelsDatePicker(identifier: "datePicker", initialDate: date)
            } else {
                return alert
            }
        }
        datePicker?.delegate = self

        for alertTextField in AlertTextFields.allCases {
            switch alertTextField {
            case .name:
                alert.addTextField {
                    $0.placeholder = alertTextField.rawValue
                    if let reminder = reminder {
                        $0.text = reminder.name
                    }
                }
            case .date:
                alert.addTextField {
                    $0.placeholder = alertTextField.rawValue
                    $0.inputView = datePicker
                    if let reminder = reminder,
                       let date = reminder.date {
                        $0.text = Formatters.dateFormatter.string(from: date)
                    }
                }
            }
        }
        return alert
    }

    private func makeAlertActions(_ alert: UIAlertController,
                                  type: AlertType,
                                  reminder: CDReminder?) -> UIAlertController {
        let actionTitle: String
        switch type {
        case .newReminder:
            actionTitle = "Napravi podsjetnik"
        case .editingReminder:
            actionTitle = "Uredi podsjetnik"
        }
        alert.addAction(UIAlertAction(title: actionTitle,
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
        }))

        alert.addAction(UIAlertAction(title: "Odustani",
                                      style: .cancel,
                                      handler: { [weak self] _ in
            self?.presentedAlert = nil
            self?.dismiss(animated: true)
        }))
        return alert
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
              let date = Formatters.dateFormatter.date(from: dateString) else { return (nil, nil) }
        return (name, date)
    }
}

extension RemindersViewController: DateInputDelegate {

    func datePicker(_ identifier: String, didSelectDate date: Date?) {
        if identifier == "datePicker" {
            guard let date = date,
                  let alert = presentedAlert else { return }
            alert.textFields?[1].text = Formatters.dateFormatter.string(from: date)
        }
    }

}
