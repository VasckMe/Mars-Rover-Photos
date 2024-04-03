//
//  HomeRouter.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit

protocol HomeRouterProtocol {
    func openDetailScreen(input: DetailInputModel)
}

final class HomeRouter: HomeRouterProtocol {
    weak var view: HomeViewController?
    
    func openDetailScreen(input: DetailInputModel) {
        let detailScreen = DetailAssembly.detailController(input: input)
        view?.navigationController?.pushViewController(detailScreen, animated: true)
    }
}
