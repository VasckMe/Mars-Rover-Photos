//
//  HomeCellItem.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

import Foundation

struct HomeCellItem {
    let rover: String
    let camera: String
    let date: String
    let imageStringURL: String
    
    var formattedDate: String {
        let formatter = HelperUtilities.dateFormatter
        formatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        guard let defaultDate = formatter.date(from: date) else {
            return "invalid date format"
        }
        formatter.dateFormat = DateFormat.MMMdyyyy.rawValue
        return formatter.string(from: defaultDate)
    }
}

// MARK: - Init from business model

extension HomeCellItem {
    init(photo: Photo) {
        self.rover = photo.roverType
        self.camera = photo.cameraFullName
        self.date = photo.date
        self.imageStringURL = photo.imageStringURL
    }
}
