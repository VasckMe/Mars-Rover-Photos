//
//  HomeViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation
import Combine

final class HomeViewModel {
    private let networkService: NetworkServiceProtocol
    
    var modelPublisher = PassthroughSubject<[Photo], NetworkError>()
    
    var numberOfElements: Int {
        models.count
    }
    
    var models: [Photo] = []
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

// MARK: - HomeViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    func fetchPhotos() {
        Task {
            do {
                let photos = try await networkService.fetchPhotos(rover: .all, camera: nil, date: "2015-06-03")
                await MainActor.run {
                    models = photos
                    modelPublisher.send(photos)
                }
            } catch {
                await MainActor.run {
                    models = []
                    modelPublisher.send(completion: .failure(error as? NetworkError ?? .unknown))
                }
            }
        }
    }
}
