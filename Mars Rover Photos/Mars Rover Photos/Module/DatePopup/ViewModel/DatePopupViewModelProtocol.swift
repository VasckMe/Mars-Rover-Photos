//
//  DatePopupViewModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import Foundation

protocol DatePopupViewModelProtocol {    
    func didTriggerSaveButton()
    func didTriggerCloseButton()
    func didTriggerDatePicker(date: Date)
}
