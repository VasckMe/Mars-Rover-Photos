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
    var roverPublisher: CurrentValueSubject<String, Never> { get }
    var cameraPublisher: CurrentValueSubject<String, Never> { get }
    var datePublisher: CurrentValueSubject<Date, Never> { get }
    var isPickerSheetHidden: CurrentValueSubject<Bool, Never> { get }
    
    var modelPublisher: PassthroughSubject<[Photo], NetworkError> { get }
    var pickerSheetViewModel: PassthroughSubject<PickerBottomSheetViewModelProtocol, Never> { get }
    var numberOfElements: Int { get }
    
    func didTriggerRoverButton()
    func didTriggerCameraButton()
    func didTriggerDateButton()
    func didTriggerViewLoad()
    func didTriggerReachEndOfList()
    func didTriggerSelectItem(at index: Int)
    func displayModel(at index: Int) -> HomeCellItem?    
}
