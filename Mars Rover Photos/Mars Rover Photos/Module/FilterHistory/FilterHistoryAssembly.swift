//
//  FilterHistoryAssembly.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import UIKit

struct FilterHistoryAssembly {
    static func filterHistoryController(delegate: FilterHistoryDelegate) -> UIViewController {
        let view = FilterHistoryViewController()
        let router = FilterHistoryRouter()
        router.view = view
        
        let viewModel = FilterHistoryViewModel(
            delegate: delegate,
            persistenceService: PersistenceService(persistenceManager: PersistenceStorageManager.shared),
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
