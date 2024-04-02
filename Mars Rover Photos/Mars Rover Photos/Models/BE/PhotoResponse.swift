//
//  PhotoResponse.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

struct PhotoResponse: Decodable {
    let id: Int
    let sol: Int
    let camera: CameraResponse
    let imageSrc: String
    let earthDate: String
    let rover: RoverResponse

    private enum CodingKeys: String, CodingKey {
        case id
        case sol
        case camera
        case imageSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}
