//
//  NetworkService.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation

final class NetworkService {
    private let executor: HTTPRequestExecutorProtocol
    
    private var currentPage = 1
    
    init(executor: HTTPRequestExecutorProtocol) {
        self.executor = executor
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func fetchPhotos(rover: RoverType, camera: String?, date: String) async throws -> [Photo] {
        if rover == .all {
            return try await fetchAllphotos(camera: camera, date: date)
        } else {
            return try await fetchRoverPhotos(rover: rover, camera: camera, date: date)
        }
    }
    
    func fetchAllphotos(camera: String?, date: String) async throws -> [Photo] {
        do {
            async let curiosity = fetchPhotos(rover: .curiosity, camera: camera, date: date)
            async let opportunity = fetchPhotos(rover: .opportunity, camera: camera, date: date)
            async let spirit = fetchPhotos(rover: .spirit, camera: camera, date: date)
            
            let curiosityPhotos = try await curiosity
            let opportunityPhotos = try await opportunity
            let spiritPhotos = try await spirit
            
            var combindedPhotos: [Photo] = []
            combindedPhotos.append(contentsOf: curiosityPhotos)
            combindedPhotos.append(contentsOf: opportunityPhotos)
            combindedPhotos.append(contentsOf: spiritPhotos)
            
            return combindedPhotos
        } catch {
            throw error
        }
    }
    
    func fetchRoverPhotos(rover: RoverType, camera: String?, date: String) async throws -> [Photo] {
        do {
            let response: PhotosResponse = try await executor.execute(request: .getRoverPhotos(
                rover: rover.rawValue,
                camera: camera,
                date: date,
                page: currentPage)
            )
            return response.photos.map { Photo(response: $0) }
        } catch {
            throw error
        }
    }
    
//    func fetchAllPhotos() async throws -> [Photo] {
//        do {
//            let response: PhotosResponse = try await executor.execute(request: .getRoverPhotos(
//                rover: "curiosity",
//                camera: nil,
//                date: "2015-06-03",
//                page: 1)
//            )
//            return response.photos.map { Photo(response: $0) }
//        } catch {
//            throw error
//        }
//    }
}

// MARK: - Private

private extension NetworkService {
    func fetch(from rover: RoverType, camera: String, Data: String) {
        
    }
}
