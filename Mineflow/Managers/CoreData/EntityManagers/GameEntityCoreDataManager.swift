//
//  GameEntityCoreDataManager.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import Foundation
import CoreData


final class GameCoreDataManager: CoreDataManager {

    
    typealias Entity = GameEntity
    
    let persistentController: PersistenceStore
    
    init(persistentController: PersistenceStore = PersistenceStore()) {
        self.persistentController = persistentController
    }
        
    func fetch(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [GameEntity] {
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        let context = persistentController.mainContext
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            LoggerInfo.log(error)
            throw error
        }
    }
    
    func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func createNewEntity(context: NSManagedObjectContext) -> GameEntity {
        return GameEntity(context: context)
    }
    
    func delete(entity: GameEntity, context: NSManagedObjectContext) {
        context.delete(entity)
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = GameEntity.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = persistentController.mainContext
        do {
            try context.execute(deleteRequest)
            context.reset()
            
        } catch {
            LoggerInfo.log("Bimbo (CoreData) Error: Failed to batch delete stats: \(error)")

        }
    }
    
    
}
