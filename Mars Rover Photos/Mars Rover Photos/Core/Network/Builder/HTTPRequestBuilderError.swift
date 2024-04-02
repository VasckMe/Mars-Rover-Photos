//
//  HTTPRequestBuilderError.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

enum HTTPRequestBuilderError: Error {
    case invalidBaseURL
    case invalidQueryParameters
    case invalidBody
    
    var description: String {
        switch self {
        case .invalidBaseURL:
            return "Invalid base URL"
        case .invalidQueryParameters:
            return "Invalid query params"
        case .invalidBody:
            return "Invalid body"
        }
    }
}
