//
//  RoverPickerBottomSheetViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Combine

final class RoverPickerBottomSheetViewModel: PickerBottomSheetViewModelProtocol {
    weak var delegate: RoverPickerBottomSheetDelegate?
    
    var titlePublisher = PassthroughSubject<String, Never>()
    var displayItemsPublisher = PassthroughSubject<[PickerDisplayItem], Never>()
    var numberOfItems: Int {
        inputModel.displayItems.count
    }
    
    private let inputModel: PickerBottomSheetInputmodel
    private var choosedItem: PickerDisplayItem?
    
    init(input: PickerBottomSheetInputmodel, delegate: RoverPickerBottomSheetDelegate) {
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
        delegate?.save(rover: choosedItem?.name ?? "")
        delegate?.closePickerBottomSheet()
    }
    
    func didTriggerSelectItem(at index: Int) {
        guard let item = inputModel.displayItems[safe: index] else {
            return
        }
        
        choosedItem = item
    }
}
