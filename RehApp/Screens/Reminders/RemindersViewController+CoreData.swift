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
            NSSortDescriptor(key: "time", ascending: true),
            NSSortDescriptor(key: "name", ascending: true)
        ]
        do {
            let reminders = try mainViewContext.fetch(reminderFetchRequest)
            allReminderIDs = reminders.compactMap({ $0.id })
            let remindersVM = reminders.compactMap { $0.viewModel }
            print()
            for viewModel in remindersVM {
                print(viewModel)
            }
            rebuildSnapshot(reminders: remindersVM, animatingDifferences: true)
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }

    func createReminder(name: String,
                        time: Date,
                        id: UUID) {
        let reminder = CDReminder(context: mainViewContext)
        reminder.name = name
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: time)
        dateComponents.minute = Calendar.current.component(.minute, from: time)
        reminder.time = Calendar.current.date(from: dateComponents)
        reminder.id = id
        reminder.isRepeating = false
        saveMainContext(rebuildSnapshot: true)
    }

    func getReminder(id: UUID) -> CDReminder? {
        let request = CDReminder.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        return try? mainViewContext.fetch(request).first
    }

    func deleteReminder(id: UUID) {
        guard let reminder = getReminder(id: id) else { return }
        mainViewContext.delete(reminder)
        saveMainContext(rebuildSnapshot: true)
    }

    func updateReminder(id: UUID,
                        newName: String?,
                        newTime: Date?,
                        isRepeating: Bool = false,
                        rebuildSnapshot: Bool) {
        guard let reminder = getReminder(id: id) else { return }
        if let newName = newName {
            reminder.name = newName
        }
        if let newTime = newTime {
            var dateComponents = DateComponents()
            dateComponents.hour = Calendar.current.component(.hour, from: newTime)
            dateComponents.minute = Calendar.current.component(.minute, from: newTime)
            reminder.time = Calendar.current.date(from: dateComponents)
        }
        reminder.isRepeating = isRepeating
        saveMainContext(rebuildSnapshot: rebuildSnapshot)
    }

    private func saveMainContext(rebuildSnapshot: Bool) {
        do {
            try mainViewContext.save()
            if rebuildSnapshot {
                getAllReminders()
            }
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }
}
