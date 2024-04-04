//
//  FilterHistoryViewModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Combine

protocol FilterHistoryViewModelProtocol {
    var displayItemsPublisher: PassthroughSubject<[FilterDisplayItem], Never> { get }
    var numberOfElements: Int { get }
    
    func didTriggerViewLoad()
    func didTriggerBackButton()
    func didTriggerSelectItem(at index: Int)
    func displayModel(at index: Int) -> FilterDisplayItem?
}
