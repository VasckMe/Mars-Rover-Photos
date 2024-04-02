//
//  NetworkServiceProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

protocol NetworkServiceProtocol {
    func fetchPhotos(rover: RoverType, camera: String?, date: String) async throws -> [Photo]
}
