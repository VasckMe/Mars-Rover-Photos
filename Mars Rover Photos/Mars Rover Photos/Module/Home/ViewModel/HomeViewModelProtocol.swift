//
//  HomeViewModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Combine
import Foundation

protocol HomeViewModelProtocol {
    var isCenterActiityIndicatorHiddenPublisher: CurrentValueSubject<Bool, Never> { get }
    var isBottomActiityIndicatorHiddenPublisher: CurrentValueSubject<Bool, Never> { get }
    var isPickerSheetHidden: CurrentValueSubject<Bool, Never> { get }

    var roverPublisher: CurrentValueSubject<String, Never> { get }
    var cameraPublisher: CurrentValueSubject<String, Never> { get }
    var datePublisher: CurrentValueSubject<Date, Never> { get }
    
    var modelPublisher: PassthroughSubject<[Photo], Never> { get }
    var pickerSheetViewModelPublisher: PassthroughSubject<PickerBottomSheetViewModelProtocol, Never> { get }
    
    var numberOfElements: Int { get }
    
    func didTriggerRoverButton()
    func didTriggerHistoryButton()
    func didTriggerCameraButton()
    func didTriggerDateButton()
    func didTriggerSaveButton()
    func didTriggerViewLoad()
    func didTriggerReachEndOfList()
    func didTriggerSelectItem(at index: Int)
    func displayModel(at index: Int) -> HomeCellItem?    
}
