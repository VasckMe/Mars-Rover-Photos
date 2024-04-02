//
//  HTTPPath.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

enum HTTPPath {
    case rovers
    case rover(rover: String)
    
    var string: String {
        switch self {
        case .rovers:
            return "/rovers"
        case .rover(let rover):
            return "/rovers/\(rover)/photos"
        }
    }
}
