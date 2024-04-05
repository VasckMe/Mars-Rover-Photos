//
//  FilterModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Foundation

struct FilterModel {
    let rover: String
    let camera: String
    let date: Date
}

// MARK: - Init from persistence model

extension FilterModel {
    init?(model: PersistenceFilter) {
        guard
            let roverName = model.rover,
            let cameraName = model.camera,
            let date = model.date
        else {
            return nil
        }
        
        self.rover = roverName
        self.camera = cameraName
        self.date = date
    }
}

// MARK: - Init from display model

extension FilterModel {
    init(displayModel: FilterDisplayItem) {
        self.rover = displayModel.rover
        self.camera = displayModel.camera
        self.date = displayModel.date
    }
}
