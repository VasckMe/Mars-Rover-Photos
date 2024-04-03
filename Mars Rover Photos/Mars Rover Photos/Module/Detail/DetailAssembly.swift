//
//  DetailAssembly.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit

struct DetailAssembly {
    static func detailController(input: DetailInputModel) -> UIViewController {
        let view = DetailViewController(nibName: DetailViewController.nibName, bundle: nil)
        let router = DetailRouter()
        router.view = view
        
        let viewModel = DetailViewModel(input: input, router: router)
        view.viewModel = viewModel
        return view
    }
}
