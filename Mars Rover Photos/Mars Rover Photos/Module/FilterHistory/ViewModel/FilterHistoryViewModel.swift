//
//  FilterHistoryViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Combine

final class FilterHistoryViewModel {
    weak var delegate: FilterHistoryDelegate?
    
    var numberOfElements: Int {
        return displayItems.count
    }
    
    var displayItemsPublisher = PassthroughSubject<[FilterDisplayItem], Never>()

    private let persistenceService: PersistenceServiceProtocol
    private let router: FilterHistoryRouterProtocol
    private var displayItems: [FilterDisplayItem] = []
    
    init(
        delegate: FilterHistoryDelegate,
        persistenceService: PersistenceServiceProtocol,
        router: FilterHistoryRouterProtocol
    ) {
        self.delegate = delegate
        self.persistenceService = persistenceService
        self.router = router
    }
}

// MARK: - FilterHistoryViewModelProtocol

extension FilterHistoryViewModel: FilterHistoryViewModelProtocol {
    func didTriggerViewLoad() {
        fetch()
    }
    
    func didTriggerBackButton() {
        router.closeFilterHistoryScreen()
    }
    
    func didTriggerSelectItem(at index: Int) {
        guard let displayItem = displayItems[safe: index] else {
            return
        }
        
        let useAction = { [weak self] in
            self?.delegate?.use(filter: FilterModel(displayModel: displayItem))
            self?.router.closeFilterHistoryScreen()
        }
        
        let deleteAction = { [weak self] in
            try? self?.persistenceService.removeFilter(FilterModel(displayModel: displayItem))
            self?.fetch()
        }
        
        router.showFilterActionAlertSheet(useCompletion: useAction, deleteCompletion: deleteAction)
    }
    
    func displayModel(at index: Int) -> FilterDisplayItem? {
        return displayItems[safe: index]
    }
}

// MARK: - Private

private extension FilterHistoryViewModel {
    func fetch() {
        do {
            let results = try persistenceService.getFilters()
            displayItems = results.map{FilterDisplayItem(model: $0)}
            displayItemsPublisher.send(displayItems)
        } catch {
            displayItems = []
            displayItemsPublisher.send(displayItems)
        }
    }
}
