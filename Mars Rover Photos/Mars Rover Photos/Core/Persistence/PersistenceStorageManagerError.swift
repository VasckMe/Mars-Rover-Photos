//
//  PersistenceStorageManagerError.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

enum PersistenceStorageManagerError: Error {
    case invalidContextFetch
    case invalidContextSave
    case invalidFetchedModelForCasting
    case unknown
}
