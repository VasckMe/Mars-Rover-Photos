//
//  PickerBottomSheetViewModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Combine

protocol PickerBottomSheetViewModelProtocol {
    var titlePublisher: PassthroughSubject<String, Never> { get }
    var displayItemsPublisher: PassthroughSubject<[PickerDisplayItem], Never> { get }
    var numberOfItems: Int { get }
    var selectedItemIndex: Int { get }
    
    func displayModel(at index: Int) -> PickerDisplayItem?
    func didTriggerUpdatePublishers()
    func didTriggerCloseButton()
    func didTriggerSaveButton()
    func didTriggerSelectItem(at index: Int)
}
