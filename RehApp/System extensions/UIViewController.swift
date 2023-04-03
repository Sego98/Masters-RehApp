//
//  UIViewController.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation
import UIKit
import CoreData

extension UIViewController {

    /// The main queue’s managed object context.
    var mainViewContext: NSManagedObjectContext {
        let container = NSPersistentContainer(name: "RehApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        })
        return container.viewContext
    }
}
