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
    
//    var formattedDate: Date {
//        let formatter = HelperUtilities.dateFormatter
//        formatter.dateFormat = DateFormat.MMMdyyyy.rawValue
//        return formatter.string(from: date)
//    }
}

extension HomeCellItem {
    init(photo: Photo) {
        self.rover = photo.roverType
        self.camera = photo.cameraFullName
        self.date = photo.date
    }
}
