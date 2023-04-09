//
//  NSManagedObject.swift
//  RehApp
//
//  Created by Akademija on 09.04.2023..
//

import CoreData

extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
