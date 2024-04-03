//
//  HomeViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation
import Combine

final class HomeViewModel {
    private var networkService: NetworkServiceProtocol
    private let router: HomeRouterProtocol
    
    var modelPublisher = PassthroughSubject<[Photo], NetworkError>()
    var showIndicatorPublisher = PassthroughSubject<Bool, Never>()
    
    var numberOfElements: Int {
        models.count
    }
    
    var models: [Photo] = []
    private var displayModels: [HomeCellItem] = []
    
    init(networkService: NetworkServiceProtocol, router: HomeRouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
}

// MARK: - HomeViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    func displayModel(at index: Int) -> HomeCellItem? {
        guard let viewModel = displayModels[safe: index] else {
            return nil
        }
        
        return viewModel
    }
    
    func didTriggerViewLoad() {
        fetch()
    }
    
    func didTriggerReachEndOfList() {
        fetchNext()
    }
    
    func didTriggerSelectItem(at index: Int) {
        guard let model = models[safe: index] else {
            return
        }
        
        router.openDetailScreen(input: DetailInputModel(imageStringURL: model.imageStringURL))
    }
}

private extension HomeViewModel {
    func fetch() {
        Task {
            do {
                let photos = try await networkService.fetchPhotos(rover: .all, camera: nil, date: "2015-06-03")
                await MainActor.run {
                    models = photos
                    displayModels = photos.map { HomeCellItem(photo: $0) }
                    modelPublisher.send(photos)
                }
            } catch {
                await MainActor.run {
                    models = []
                    displayModels = []
                    modelPublisher.send(completion: .failure(error as? NetworkError ?? .unknown))
                }
            }
        }
    }
    
    func fetchNext() {
        guard !networkService.isLoading else {
            return
        }
        
        showIndicatorPublisher.send(true)
        
        Task {
            do {
                let photos = try await networkService.fetchPhotos(rover: .all, camera: nil, date: "2015-06-03")
                await MainActor.run {
                    models.append(contentsOf: photos)
                    displayModels = models.map { HomeCellItem(photo: $0) }
                    modelPublisher.send(models)
                    showIndicatorPublisher.send(false)
                }
            } catch {
                await MainActor.run {
                    models = []
                    displayModels = []
                    modelPublisher.send(completion: .failure(error as? NetworkError ?? .unknown))
                    showIndicatorPublisher.send(false)
                }
            }
        }
    }
}
