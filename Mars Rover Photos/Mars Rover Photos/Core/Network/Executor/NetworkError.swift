//
//  NetworkError.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

enum NetworkError: Error {
    case badResponse
    case badParsing
    case offline
    case unknown
    
    var description: String {
        switch self {
        case .badResponse:
            return "Response error"
        case .badParsing:
            return "Parsing error"
        case .offline:
            return "Offline"
        case .unknown:
            return "Generic error"
        }
    }
}
