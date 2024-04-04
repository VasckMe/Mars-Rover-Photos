//
//  PersistenceStorageManagerProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import CoreData

protocol PersistenceStorageManagerProtocol {
    var context: NSManagedObjectContext { get }
    
    func retrieveObjects<T: NSManagedObject>(type: T.Type) throws -> [T]
    func deleteObjects<T: NSManagedObject>(type: T.Type, predicate: NSPredicate?) throws
    func save() throws
}
