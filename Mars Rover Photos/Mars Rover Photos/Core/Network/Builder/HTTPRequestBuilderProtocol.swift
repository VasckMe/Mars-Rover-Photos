//
//  HTTPRequestBuilderProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation

protocol HTTPRequestBuilderProtocol {
    func build(httpRequest: HTTPRequest) throws -> URLRequest
}
