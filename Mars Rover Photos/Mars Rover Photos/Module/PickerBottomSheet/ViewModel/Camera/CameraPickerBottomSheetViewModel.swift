//
//  CameraPickerBottomSheetViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Foundation
import Combine

final class CameraPickerBottomSheetViewModel: PickerBottomSheetViewModelProtocol {
    weak var delegate: CameraPickerBottomSheetDelegate?
    
    var titlePublisher = PassthroughSubject<String, Never>()
    var displayItemsPublisher = PassthroughSubject<[PickerDisplayItem], Never>()
    var numberOfItems: Int {
        inputModel.displayItems.count
    }
    
    private let inputModel: PickerBottomSheetInputmodel
    private var choosedItem: PickerDisplayItem?
    
    init(input: PickerBottomSheetInputmodel, delegate: CameraPickerBottomSheetDelegate) {
        self.inputModel = input
        self.delegate = delegate
    }
    
    func displayModel(at index: Int) -> PickerDisplayItem? {
        return inputModel.displayItems[safe: index]
    }
    
    func didTriggerUpdatePublishers() {
        titlePublisher.send(inputModel.title)
        displayItemsPublisher.send(inputModel.displayItems)
    }
    
    func didTriggerCloseButton() {
        delegate?.closePickerBottomSheet()
    }
    
    func didTriggerSaveButton() {
        delegate?.save(camera: choosedItem?.name ?? "")
        delegate?.closePickerBottomSheet()
    }
    
    func didTriggerSelectItem(at index: Int) {
        guard let item = inputModel.displayItems[safe: index] else {
            return
        }
        
        choosedItem = item
    }
}
