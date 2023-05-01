//
//  RehAppCache+Container.swift
//  RehApp
//
//  Created by Petar Ljubotina on 09.04.2023..
//

import CoreData

extension RehAppCache {

    static func makeContainer(inMemory: Bool) -> NSPersistentContainer {
        let name = "RehAppCache"

        let container = NSPersistentContainer(name: name)
        if let storeDescription = container.persistentStoreDescriptions.first {
            if inMemory {
                storeDescription.url = URL(fileURLWithPath: "/dev/null")
            }
        }

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
#if DEBUG
                print("❌ Container failed to load with error: \(error.localizedDescription)")
#endif
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.undoManager = nil
        return container
    }

}
