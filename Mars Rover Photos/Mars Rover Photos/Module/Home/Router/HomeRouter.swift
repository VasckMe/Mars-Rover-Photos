//
//  HomeRouter.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import UIKit

protocol HomeRouterProtocol {
    func openDetailScreen(input: DetailInputModel)
    func openDatePopupScreen(delegate: DatePopupDelegate)
}

final class HomeRouter: HomeRouterProtocol {
    weak var view: HomeViewController?
    
    func openDetailScreen(input: DetailInputModel) {
        let detailScreen = DetailAssembly.detailController(input: input)
        view?.navigationController?.pushViewController(detailScreen, animated: true)
    }
    
    func openDatePopupScreen(delegate: DatePopupDelegate) {
        let datePopupScreen = DatePopupAssembly.datePopupController(delegate: delegate)
        datePopupScreen.modalPresentationStyle = .overFullScreen
        view?.navigationController?.present(
            datePopupScreen,
            animated: false,
            completion: {
                guard let view = datePopupScreen as? DatePopupViewControllerProtocol else {
                    return
                }
                
                view.show()
        })
    }
}
