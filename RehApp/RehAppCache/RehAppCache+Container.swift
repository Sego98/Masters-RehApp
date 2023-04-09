//
//  RehAppCache+Container.swift
//  RehApp
//
//  Created by Akademija on 09.04.2023..
//

import CoreData

extension RehAppCache {

    static func makeContainer(inMemory: Bool) -> NSPersistentContainer {
        let name = "RehAppCache"
//        guard let coreDataFileURL = Bundle.main.url(forResource: name, withExtension: "mom"),
//              let mom = NSManagedObjectModel(contentsOf: coreDataFileURL) else {
//            fatalError("Could not find Core data model")
//        }
//        let container = NSPersistentContainer(name: name, managedObjectModel: mom)

        let container = NSPersistentContainer(name: name)
        if let storeDescription = container.persistentStoreDescriptions.first {
            if inMemory {
                storeDescription.url = URL(fileURLWithPath: "/dev/null")
            }
        }

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.undoManager = nil
        return container
    }

}
