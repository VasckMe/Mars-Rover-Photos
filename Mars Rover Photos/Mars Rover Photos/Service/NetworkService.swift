//
//  NetworkService.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation

final class NetworkService {
    private let executor: HTTPRequestExecutorProtocol
    
    var isLoading: Bool = false
    private var currentPage = 1
    
    init(executor: HTTPRequestExecutorProtocol) {
        self.executor = executor
    }
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    // TODO: - Make Date instead of String
    func fetchNew(rover: RoverType, camera: String?, date: String) async throws -> [Photo] {
        if isLoading {
            throw CancellationError()
        }
        
        isLoading = true
        
        currentPage = 1
        
        return try await fetchPhotos(rover: rover, camera: camera, date: date, page: currentPage)
    }
    
    func fetchNext(rover: RoverType, camera: String?, date: String) async throws -> [Photo] {
        if isLoading {
            throw CancellationError()
        }
        
        isLoading = true
        
        return try await fetchPhotos(rover: rover, camera: camera, date: date, page: currentPage)
    }
}

// MARK: - Private

private extension NetworkService {
    func fetchPhotos(rover: RoverType, camera: String?, date: String, page: Int) async throws -> [Photo] {
        do {
            let result = rover == .all
                ? try await fetchAll(camera: camera, date: date, page: page)
                : try await fetch(rover: rover, camera: camera, date: date, page: page)
            currentPage += 1
            isLoading = false
            return result
        } catch {
            isLoading = false
            throw error
        }
    }
    
    func fetch(rover: RoverType, camera: String?, date: String, page: Int) async throws -> [Photo] {
        do {
            let response: PhotosResponse = try await executor.execute(request: .getRoverPhotos(
                rover: rover.rawValue,
                camera: camera,
                date: date,
                page: page)
            )
            return response.photos.map { Photo(response: $0) }
        } catch {
            throw error
        }
    }
    
    func fetchAll(camera: String?, date: String, page: Int) async throws -> [Photo] {
        do {
            async let curiosity = fetch(rover: .curiosity, camera: camera, date: date, page: page)
            async let opportunity = fetch(rover: .opportunity, camera: camera, date: date, page: page)
            async let spirit = fetch(rover: .spirit, camera: camera, date: date, page: page)
            
            let curiosityPhotos = try await curiosity
            let opportunityPhotos = try await opportunity
            let spiritPhotos = try await spirit
            
            var combinedPhotos: [Photo] = []
            combinedPhotos.append(contentsOf: curiosityPhotos)
            combinedPhotos.append(contentsOf: opportunityPhotos)
            combinedPhotos.append(contentsOf: spiritPhotos)
        
            return combinedPhotos
        } catch {
            throw error
        }
    }
}
