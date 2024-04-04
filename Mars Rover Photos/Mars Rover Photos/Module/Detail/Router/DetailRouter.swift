//
//  DetailRouter.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

final class DetailRouter: DetailRouterProtocol {
    weak var view: DetailViewController?
    
    func closeDetailScreen() {
        view?.navigationController?.popViewController(animated: true)
    }
}
