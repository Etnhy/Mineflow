//
//  CoreDataManager.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import Foundation
import CoreData

protocol CoreDataManager {
    associatedtype Entity: NSManagedObject
    func save(context: NSManagedObjectContext) throws
    func fetch(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) throws -> [Entity]
    func createNewEntity(context: NSManagedObjectContext) -> Entity
    func delete(entity: Entity, context: NSManagedObjectContext)
    func deleteAll()
}


final class CoreDataRepository {
    let coreDataManager: GameCoreDataManager
    
    init(coreDataManager: GameCoreDataManager = GameCoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    func saveGameModel(_ model: GameModel) throws {
        let context = self.coreDataManager.persistentController.mainContext
        
        let newGameEntity = self.coreDataManager.createNewEntity(context: context)
        
        newGameEntity.configure(with: model)
        
        try self.coreDataManager.save(context: context)
    }
    
    func fetchGameModels() throws -> [GameModel] {
        
        let fetchedEntities: [GameEntity] = try self.coreDataManager.fetch(predicate: nil, sortDescriptors: nil)
        
        return fetchedEntities.map { $0.toModel }
    }
    
    func deleteAllGameModels() throws {
        self.coreDataManager.deleteAll()
    }
}

