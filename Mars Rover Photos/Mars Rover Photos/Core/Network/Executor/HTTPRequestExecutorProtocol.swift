//
//  HTTPRequestExecutorProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

protocol HTTPRequestExecutorProtocol {
    func execute<T: Decodable>(request: HTTPRequest) async throws -> T
}
