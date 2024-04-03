//
//  HomeViewModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Combine

protocol HomeViewModelProtocol {
    var modelPublisher: PassthroughSubject<[Photo], NetworkError> { get }
    var showIndicatorPublisher: PassthroughSubject<Bool, Never> { get }
    var numberOfElements: Int { get }
    
    func didTriggerViewLoad()
    func didTriggerReachEndOfList()
    func didTriggerSelectItem(at index: Int)
    func displayModel(at index: Int) -> HomeCellItem?    
}
