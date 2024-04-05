//
//  PersistenceService.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Foundation

final class PersistenceService {
    private let persistenceManager: PersistenceStorageManagerProtocol
    
    init(persistenceManager: PersistenceStorageManagerProtocol) {
        self.persistenceManager = persistenceManager
    }
}

// MARK: - PersistenceServiceProtocol

extension PersistenceService: PersistenceServiceProtocol {
    func saveFilter(_ filter: FilterModel) throws {
        do {
            var persistenceModel = PersistenceFilter(context: self.persistenceManager.context)
            persistenceModel.rover = filter.rover
            persistenceModel.date = filter.date
            persistenceModel.camera = filter.camera
            
            try self.persistenceManager.save()
        } catch {
            throw error
        }
    }
    
    func getFilters() throws -> [FilterModel] {
        do {
            let savedFilters = try self.persistenceManager.retrieveObjects(type: PersistenceFilter.self)
            return savedFilters.compactMap { FilterModel(model: $0) }
        } catch {
            throw error
        }
    }
    
    func removeFilter(_ filter: FilterModel) throws {
        do {
            let predicate = NSPredicate(format: "date == %@", filter.date as CVarArg)
            let savedFilters = try self.persistenceManager.deleteObjects(type: PersistenceFilter.self, predicate: predicate)
        } catch {
            throw error
        }
    }
}
