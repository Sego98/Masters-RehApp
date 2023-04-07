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

    func getAllActiveReminders() {
        let reminderFetchRequest = CDReminder.fetchRequest()
        reminderFetchRequest.predicate = NSPredicate(format: "date > %@", Date() as NSDate)
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
        reminder.date = date
        do {
            try mainViewContext.save()
            getAllActiveReminders()
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

    func deleteAllPastReminders() {
        let request = CDReminder.fetchRequest()
        request.predicate = NSPredicate(format: "date < %@", Date() as NSDate)
        guard let reminders = try? mainViewContext.fetch(request) else {
            return
        }
        for reminder in reminders {
            mainViewContext.delete(reminder)
        }
        do {
            try mainViewContext.save()
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }

    func updateReminder(_ reminder: CDReminder, newName: String, newDate: Date) {
        reminder.name = newName
        reminder.date = newDate
        saveMainContext()
    }

    private func saveMainContext() {
        do {
            try mainViewContext.save()
            getAllActiveReminders()
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }
}