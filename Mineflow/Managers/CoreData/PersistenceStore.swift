//
//  PersistenceStore.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import Foundation
import CoreData

final class PersistenceStore: @unchecked Sendable {
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Mineflow")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("load error Core Data: \(error), \(error.userInfo)")
            }
        }
    }
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
