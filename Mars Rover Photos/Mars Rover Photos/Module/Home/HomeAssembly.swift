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
        let viewModel = HomeViewModel()
        view.viewModel = viewModel
        return view
    }
}
