//
//  PersistenceStorageManager.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import CoreData

final class PersistenceStorageManager {
    static let shared: PersistenceStorageManagerProtocol = PersistenceStorageManager()
    
    private(set) lazy var context: NSManagedObjectContext = {
        persistentContainer.newBackgroundContext()
    }()
    
    private let containerName = "Filter"
    private let persistentContainer: NSPersistentContainer
    
    init() {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                print(error)
            }
        }
        persistentContainer = container
    }
}

// MARK: - PersistanceStorageManagerProtocol

extension PersistenceStorageManager: PersistenceStorageManagerProtocol {
    func retrieveObjects<T: NSManagedObject>(type: T.Type) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            throw PersistenceStorageManagerError.invalidContextFetch
        }
    }
    
    func deleteObjects<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil) throws {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            
            result.forEach { context.delete($0) }
            
            try save()
        } catch {
            throw PersistenceStorageManagerError.invalidContextFetch
        }
    }
    
    func save() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                throw PersistenceStorageManagerError.invalidContextSave
            }
        }
    }
}
