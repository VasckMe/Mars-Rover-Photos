//
//  CameraInfoResponse.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

struct CameraInfoResponse: Decodable {
    let name: String
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
