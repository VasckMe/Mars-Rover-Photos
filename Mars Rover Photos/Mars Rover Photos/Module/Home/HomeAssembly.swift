//
//  HomeAssembly.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import UIKit

struct HomeAssembly {
    static func homeController() -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter()
        router.view = view
        
        let viewModel = HomeViewModel(
            persistenceService: PersistenceService(persistenceManager: PersistenceStorageManager.shared),
            networkService: NetworkService(executor: NetworkAssembly.requestExecutor),
            router: router
        )
        view.viewModel = viewModel
        return view
    }
}
