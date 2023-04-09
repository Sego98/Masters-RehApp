//
//  RehAppCache+Reminders.swift
//  RehApp
//
//  Created by Akademija on 09.04.2023..
//

import Foundation
import CoreData

extension RehAppCache {

    func getAllReminders() -> [CDReminder]? {
        let reminderFetchRequest = CDReminder.fetchRequest()
        reminderFetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "time", ascending: true),
            NSSortDescriptor(key: "name", ascending: true)
        ]
        return try? mainViewContext.fetch(reminderFetchRequest)
    }

    func getReminder(id: UUID) -> CDReminder? {
        let request = CDReminder.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        return try? mainViewContext.fetch(request).first
    }

    func getReminder(atIndex index: Int) -> CDReminder? {
        guard let allReminders = getAllReminders() else {
            return nil
        }
        if index < allReminders.count, index >= 0 {
            return allReminders[index]
        } else {
            return nil
        }
    }

    func deleteReminder(id: UUID) {
        guard let reminder = getReminder(id: id) else { return }
        mainViewContext.delete(reminder)
        saveMainContext()
    }

    func updateReminder(id: UUID,
                        newName: String,
                        newTime: Date) {
        guard let reminder = getReminder(id: id) else { return }
        reminder.name = newName
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: newTime)
        dateComponents.minute = Calendar.current.component(.minute, from: newTime)
        reminder.time = Calendar.current.date(from: dateComponents)
        saveMainContext()
    }

    func updateReminder(id: UUID, isRepeating: Bool) {
        guard let reminder = getReminder(id: id) else { return }
        reminder.isRepeating = isRepeating
        saveMainContext()
    }

    func createReminder(id: UUID,
                        name: String,
                        time: Date) {
        let reminder = CDReminder(context: mainViewContext)
        reminder.name = name
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: time)
        dateComponents.minute = Calendar.current.component(.minute, from: time)
        reminder.time = Calendar.current.date(from: dateComponents)
        reminder.id = id
        reminder.isRepeating = false
        saveMainContext()
    }

    private func saveMainContext() {
        do {
            try mainViewContext.save()
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }
}
