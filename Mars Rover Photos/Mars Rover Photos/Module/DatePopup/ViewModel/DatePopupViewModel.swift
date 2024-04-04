//
//  DatePopupViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import Foundation

final class DatePopupViewModel {
    weak var delegate: DatePopupDelegate?
    
    private var date: Date = Date()
    private var router: DatePopupRouterProtocol
    
    init(router: DatePopupRouterProtocol, delegate: DatePopupDelegate) {
        self.router = router
        self.delegate = delegate
    }
}

// MARK: - DatePopupViewModelProtocol

extension DatePopupViewModel: DatePopupViewModelProtocol {
    func didTriggerCloseButton() {
        router.closeDatePopupScreen()
    }
    
    func didTriggerSaveButton() {
        delegate?.save(date: date)
        router.closeDatePopupScreen()
    }
    
    func didTriggerDatePicker(date: Date) {
        self.date = date
    }
}
