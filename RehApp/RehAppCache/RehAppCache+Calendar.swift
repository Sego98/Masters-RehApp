//
//  RehAppCache+Calendar.swift
//  RehApp
//
//  Created by Petar Ljubotina on 26.04.2023..
//

import Foundation

extension RehAppCache {

    func getAllCalendarItems() -> [CDCalendar]? {
        let fetchRequest = CDCalendar.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: true)
        ]
        return try? mainViewContext.fetch(fetchRequest)
    }

    func createCalendarItem(date: Date) {
        guard getCalendarItem(date: date) == nil else { return }
        let calendarItem = CDCalendar(context: mainViewContext)
        calendarItem.date = date
        saveMainContext()
    }

    func getCalendarItem(date: Date) -> CDCalendar? {
        let request = CDCalendar.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", date as CVarArg)
        request.fetchLimit = 1
        return try? mainViewContext.fetch(request).first
    }

    func deleteCalendarItem(date: Date) {
        guard let calendarItem = getCalendarItem(date: date) else { return }
        mainViewContext.delete(calendarItem)
        saveMainContext()
    }

}
