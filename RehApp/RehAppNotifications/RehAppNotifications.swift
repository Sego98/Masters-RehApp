//
//  RehAppNotifications.swift
//  RehApp
//
//  Created by Akademija on 09.04.2023..
//

import Foundation
import UserNotifications
import UIKit

class RehAppNotifications {

    static let shared = RehAppNotifications()

    // MARK: - Request authorization

    func requestNotificationsAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }

    // MARK: - Handle notifications

    func scheduleReminderNotification(with id: UUID) {
        guard let reminder = RehAppCache.shared.getReminder(id: id),
              let name = reminder.name,
              let time = reminder.time,
              let id = reminder.id else { return }

        let content = UNMutableNotificationContent()
        content.title = name
        content.sound = .default
        content.body = "RehabilitationNotification";

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: reminder.isRepeating)

        let request = UNNotificationRequest(identifier: id.uuidString,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)

        reconfigureNotificationsWithCorrectBadges()
    }

    func removeReminderNotification(with id: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }

    func reconfigureNotificationsWithCorrectBadges() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            let notificationsScheduledTomorrow = notifications.filter({
                guard let trigger = $0.trigger as? UNCalendarNotificationTrigger,
                      let date = trigger.nextTriggerDate() else { return false }
                return Calendar.current.isDateInTomorrow(date)
            })
            let notificationsScheduledToday = notifications.filter {
                guard let trigger = $0.trigger as? UNCalendarNotificationTrigger,
                      let date = trigger.nextTriggerDate() else { return false }
                return Calendar.current.isDateInToday(date)
            }
            let filteredNotifications = notificationsScheduledToday + notificationsScheduledTomorrow

            let newNotificationRequests = filteredNotifications.enumerated().map {
                let elementContent = $0.element.content
                let content = UNMutableNotificationContent()
                content.title = elementContent.title
                content.sound = elementContent.sound
                content.body = elementContent.body
                content.badge = NSNumber(value: $0.offset + 1)
                return UNNotificationRequest(identifier: $0.element.identifier,
                                             content: content,
                                             trigger: $0.element.trigger)
            }

            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

            for request in newNotificationRequests {
                UNUserNotificationCenter.current().add(request)
            }
        }
    }

}
