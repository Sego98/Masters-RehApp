//
//  RemindersViewController+Notifications.swift
//  RehApp
//
//  Created by Akademija on 08.04.2023..
//

import Foundation
import UIKit
import UserNotifications

extension RemindersViewController {

    func requestNotificationsAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, error in
            if let error = error {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }

    func scheduleReminderNotification(with id: UUID) {
        guard let reminder = RehAppCache.shared.getReminder(id: id),
              let name = reminder.name,
              let time = reminder.time,
              let id = reminder.id else { return }

        let content = UNMutableNotificationContent()
        content.title = name
        content.sound = .default
        content.body = "Vrijeme je da odradiš svoju zakazanu rehabilitaciju!"

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: reminder.isRepeating)

        let request = UNNotificationRequest(identifier: id.uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func removeReminderNotification(with id: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }

}
