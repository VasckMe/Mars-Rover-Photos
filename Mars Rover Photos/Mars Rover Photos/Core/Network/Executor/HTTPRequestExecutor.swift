//
//  HTTPRequestExecutor.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation

final class HTTPRequestExecutor {
    private let builder: HTTPRequestBuilderProtocol
    
    init(builder: HTTPRequestBuilderProtocol) {
        self.builder = builder
    }
}

// MARK: - HTTPRequestExecutorProtocol

extension HTTPRequestExecutor: HTTPRequestExecutorProtocol {
    func execute<T: Decodable>(request: HTTPRequest) async throws -> T {
        let urlRequest = try builder.build(httpRequest: request)
        
        let payload = try await fetchData(request: urlRequest)
        
        guard (payload.response as? HTTPURLResponse)?.statusCode == 200
            || (payload.response as? HTTPURLResponse)?.statusCode == 204
        else {
            throw NetworkError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: payload.data) else {
            throw NetworkError.badParsing
        }
        
        return object
    }
}

// MARK: - Private

private extension HTTPRequestExecutor {
    func fetchData(request: URLRequest) async throws -> (data: Data, response: URLResponse) {
        do {
            return try await fetch(request: request)
        } catch {
            switch (error as NSError).code {
            case
                NSURLErrorNotConnectedToInternet,
                NSURLErrorNetworkConnectionLost,
                NSURLErrorDataNotAllowed:
                
                throw NetworkError.offline
            default:
                throw NetworkError.unknown
            }
        }
    }
    
    func fetch(request: URLRequest) async throws -> (data: Data, response: URLResponse) {
        return try await URLSession.shared.data(for: request)
    }
}
