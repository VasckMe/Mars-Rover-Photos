//
//  Array.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 3.04.24.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        guard self.indices.contains(index) else {
            return nil
        }
        
        return self[index]
    }
}
