//
//  PersistenceServiceProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

protocol PersistenceServiceProtocol {
    func saveFilter(_ filter: FilterModel) throws
    func getFilters() throws -> [FilterModel]
}
