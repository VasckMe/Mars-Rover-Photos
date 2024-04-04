//
//  DatePopupRouter.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

final class DatePopupRouter: DatePopupRouterProtocol {
    weak var view: DatePopupViewController?
    
    init() {}
    
    func closeDatePopupScreen() {
        view?.dismiss(animated: true)
    }
}
