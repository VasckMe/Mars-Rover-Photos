//
//  NetworkAssembly.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

struct NetworkAssembly {
    static var requestExecutor: HTTPRequestExecutorProtocol {
        HTTPRequestExecutor(builder: HTTPRequestBuilder())
    }
}
