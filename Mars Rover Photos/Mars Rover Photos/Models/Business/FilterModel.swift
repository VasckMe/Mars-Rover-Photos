//
//  FilterModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

struct FilterModel {
    let rover: String
    let camera: String
    let date: String
}

extension FilterModel {
    init?(model: PersistenceFilter) {
        guard
            let roverName = model.rover,
            let cameraName = model.camera,
            let dateString = model.date
        else {
            return nil
        }
        
        self.rover = roverName
        self.camera = cameraName
        self.date = dateString
    }
}
