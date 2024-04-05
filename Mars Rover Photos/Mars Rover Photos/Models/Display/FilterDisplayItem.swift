//
//  FilterDisplayItem.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 4.04.24.
//

import Foundation

struct FilterDisplayItem {
    let rover: String
    let camera: String
    let date: Date
    
    var dateString: String {
        return HelperUtilities.dateFormat(date, to: .MMMdyyyy)
    }
}

// MARK: - Init from business model

extension FilterDisplayItem {
    init(model: FilterModel) {
        self.rover = model.rover
        self.camera = model.camera
        self.date = model.date
    }
}
