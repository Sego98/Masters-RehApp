//
//  CDReminder+CoreDataProperties.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//
//

import Foundation
import CoreData


extension CDReminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDReminder> {
        return NSFetchRequest<CDReminder>(entityName: "CDReminder")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?

}

extension CDReminder : Identifiable {

}
