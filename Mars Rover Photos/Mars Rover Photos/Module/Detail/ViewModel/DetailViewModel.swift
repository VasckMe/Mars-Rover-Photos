//
//  DetailViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import Combine

final class DetailViewModel {
    var inputPublisher = PassthroughSubject<DetailInputModel, Never>()
    
    private let router: DetailRouterProtocol
    private let inputModel: DetailInputModel
    
    init(input: DetailInputModel, router: DetailRouterProtocol) {
        self.inputModel = input
        self.router = router
    }
}

// MARK: - DetailViewModelProtocol

extension DetailViewModel: DetailViewModelProtocol {
    func didTriggerViewLoad() {
        self.inputPublisher.send(inputModel)
    }
    
    func didTriggerClose() {
        router.closeDetailScreen()
    }
}
