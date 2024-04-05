//
//  RoverPickerBottomSheetViewModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Combine

final class RoverPickerBottomSheetViewModel {
    weak var delegate: RoverPickerBottomSheetDelegate?
    
    var titlePublisher = PassthroughSubject<String, Never>()
    var displayItemsPublisher = PassthroughSubject<[PickerDisplayItem], Never>()
    var numberOfItems: Int {
        inputModel.displayItems.count
    }
    
    var selectedItemIndex: Int {
        return inputModel.displayItems
            .firstIndex(where: {$0.name == inputModel.selectedItemString}) ?? 0
    }
    
    private let inputModel: PickerBottomSheetInputmodel
    private var choosedItem: PickerDisplayItem?
    
    init(input: PickerBottomSheetInputmodel, delegate: RoverPickerBottomSheetDelegate) {
        self.inputModel = input
        self.delegate = delegate
        self.choosedItem = input.displayItems[safe: selectedItemIndex]
    }
}

// MARK: - PickerBottomSheetViewModelProtocol

extension RoverPickerBottomSheetViewModel: PickerBottomSheetViewModelProtocol {
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
