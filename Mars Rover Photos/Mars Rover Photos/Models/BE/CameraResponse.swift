//
//  CameraResponse.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

struct CameraResponse: Decodable {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case roverId = "rover_id"
        case fullName = "full_name"
    }
}
