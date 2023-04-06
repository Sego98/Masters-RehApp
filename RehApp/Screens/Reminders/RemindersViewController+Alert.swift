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

    func makeNewReminderAlert() {
        let datePicker = WheelsDatePicker(identifier: "datePicker", initialDate: Date())
        datePicker.delegate = self

        for alertTextField in AlertTextFields.allCases {
            switch alertTextField {
            case .name:
                alert.addTextField {
                    $0.placeholder = alertTextField.rawValue
                }
            case .date:
                alert.addTextField {
                    $0.placeholder = alertTextField.rawValue
                    $0.inputView = datePicker
                }
            }
        }

        alert.addAction(UIAlertAction(title: "Napravi podsjetnik",
                                      style: .default,
                                      handler: {[weak self] _ in
            guard let self = self else { return }
            self.createNewReminderFromAlert(self.alert)
            self.dismiss(animated: true)
        }))

        alert.addAction(UIAlertAction(title: "Odustani",
                                      style: .cancel,
                                      handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }))

        present(alert, animated: true)
    }

    private func createNewReminderFromAlert(_ alert: UIAlertController) {
        guard let textFields = alert.textFields else { return }
        let textFieldTexts = textFields.map { $0.text }
        guard let name = textFieldTexts[0],
              let dateString = textFieldTexts[1],
              let date = Formatters.dateFormatter.date(from: dateString) else { return }
        createReminder(name: name, date: date)
    }
}

extension RemindersViewController: DateInputDelegate {

    func datePicker(_ identifier: String, didSelectDate date: Date?) {
        if identifier == "datePicker" {
            guard let date = date else { return }
            alert.textFields?[1].text = Formatters.dateFormatter.string(from: date)
        }
    }

}
