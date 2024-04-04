//
//  HomeViewModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Combine
import Foundation

protocol HomeViewModelProtocol {
    var modelPublisher: PassthroughSubject<[Photo], NetworkError> { get }
    var showIndicatorPublisher: PassthroughSubject<Bool, Never> { get }
    var datePublisher: CurrentValueSubject<Date, Never> { get }
    var numberOfElements: Int { get }
    
    func didTriggerDateButton()
    func didTriggerViewLoad()
    func didTriggerReachEndOfList()
    func didTriggerSelectItem(at index: Int)
    func displayModel(at index: Int) -> HomeCellItem?    
}
