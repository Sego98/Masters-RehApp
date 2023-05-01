//
//  RehAppCache.swift
//  RehApp
//
//  Created by Petar Ljubotina on 09.04.2023..
//

import Foundation
import CoreData

class RehAppCache {

    static let shared = RehAppCache(inMemory: false)

    let inMemory: Bool
    var container: NSPersistentContainer
    let mainViewContext: NSManagedObjectContext

    init(inMemory: Bool) {
        self.inMemory = inMemory
        container = RehAppCache.makeContainer(inMemory: inMemory)
        mainViewContext = container.viewContext
    }

    func saveMainContext() {
        do {
            try mainViewContext.save()
#if DEBUG
            print("✅ Core data saved successfully")
#endif
        } catch {
#if DEBUG
            print("❌ Core data failed to save, error: \(error.localizedDescription)")
#endif
        }
    }
}
