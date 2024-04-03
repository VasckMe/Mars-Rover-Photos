//
//  Photo.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation

struct Photo {
    let id: Int
    let imageStringURL: String
    let roverType: String
    let cameraName: String
    let cameraFullName: String
    let date: String
}

extension Photo {
    init(response: PhotoResponse) {
        self.id = response.id
        self.imageStringURL = response.imageSrc
        self.roverType = response.rover.name
        self.cameraName = response.camera.name
        self.cameraFullName = response.camera.fullName
        self.date = response.earthDate
    }
}
