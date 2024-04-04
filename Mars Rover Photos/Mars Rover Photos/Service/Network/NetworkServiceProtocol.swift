//
//  NetworkServiceProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

protocol NetworkServiceProtocol {
    func fetchNew(rover: RoverType, camera: String?, date: String) async throws -> [Photo]
    func fetchNext(rover: RoverType, camera: String?, date: String) async throws -> [Photo]
    var isLoading: Bool { get set }
}
