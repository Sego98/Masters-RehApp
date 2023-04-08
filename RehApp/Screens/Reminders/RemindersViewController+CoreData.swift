//
//  RemindersViewController+CoreData.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation
import UIKit

extension RemindersViewController {

    // MARK: - Core data methods

    func getAllReminders() {
        let reminderFetchRequest = CDReminder.fetchRequest()
        reminderFetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: true),
            NSSortDescriptor(key: "name", ascending: true)
        ]
        do {
            let reminders = try mainViewContext.fetch(reminderFetchRequest)
            allReminders = reminders
            let remindersVM = reminders.compactMap { $0.viewModel }
            rebuildSnapshot(reminders: remindersVM, animatingDifferences: true)
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }

    func createReminder(name: String, date: Date) {
        let reminder = CDReminder(context: mainViewContext)
        reminder.name = name
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)
        reminder.date = Calendar.current.date(from: dateComponents)
        do {
            try mainViewContext.save()
            getAllReminders()
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }

    func deleteReminder(_ reminder: CDReminder) {
        mainViewContext.delete(reminder)
        saveMainContext()
    }

    func updateReminder(_ reminder: CDReminder, newName: String, newDate: Date) {
        reminder.name = newName
        reminder.date = newDate
        saveMainContext()
    }

    private func saveMainContext() {
        do {
            try mainViewContext.save()
            getAllReminders()
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }
}
