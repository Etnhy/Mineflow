//
//  UserCoreDataManager.swift
//  Mineflow
//
//  Created by evhn on 11.11.2025.
//

import Foundation
import CoreData

final class UserCoreDataManager: CoreDataManager {
    func deleteAll() {
        #warning("delete user - deleteALL")
    }
    
    
    typealias Entity = UserEntity
    
    private let persistentController: PersistenceStore
    
    init(persistentController: PersistenceStore = PersistenceStore()) {
        self.persistentController = persistentController
    }
    
    
    func fetchSingleUser() throws -> UserEntity? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest() 
        fetchRequest.fetchLimit = 1
        
        let context = persistentController.mainContext
        
        return try context.fetch(fetchRequest).first
    }
    
    func fetch(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [UserEntity] {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest() 
        let context = persistentController.mainContext
        return try context.fetch(fetchRequest)
    }
    
    func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func createNewEntity(context: NSManagedObjectContext) -> UserEntity {
        return UserEntity(context: context)
    }
    
    func delete(entity: UserEntity, context: NSManagedObjectContext) {
        context.delete(entity)
    }
}
