//
//  DetailViewModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import Combine

protocol DetailViewModelProtocol {
    var inputPublisher: PassthroughSubject<DetailInputModel, Never> { get }
    
    func didTriggerViewLoad()
    func didTriggerClose()
}
