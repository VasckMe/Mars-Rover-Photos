//
//  HTTPRequestBuilder.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

import Foundation

final class HTTPRequestBuilder: HTTPRequestBuilderProtocol {
    private let baseURLString = "https://api.nasa.gov/mars-photos/api/v1"
    
    func build(httpRequest: HTTPRequest) throws -> URLRequest {
        do {
            let url = try buildURL(request: httpRequest.request)
            return try buildURLRequest(url: url, request: httpRequest.request)
        } catch {
            throw error
        }
    }
}

// MARK: - Private
    
private extension HTTPRequestBuilder {
    func buildURL(request: HTTPRequestModelProtocol) throws -> URL {
        guard let baseURL = URL(string: baseURLString) else {
            throw HTTPRequestBuilderError.invalidBaseURL
        }
        
        return try buildURL(url: baseURL, request: request)
    }
    
    func buildURL(url: URL, request: HTTPRequestModelProtocol) throws -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw HTTPRequestBuilderError.invalidBaseURL
        }
        
        components.path += request.path.string
        
        if let queryItems = buildQueryParameters(request: request) {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw HTTPRequestBuilderError.invalidQueryParameters
        }
        
        return url
    }
    
    func buildQueryParameters(request: HTTPRequestModelProtocol) -> [URLQueryItem]? {
        if var params = request.query {
            params["api_key"] = "xfFhvZ3hFEJ9Ai5zYb35YR7f8JCF3Ei2huF5cCUC"
            return params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
//        guard let parameters = request.query else {
//            return nil
//        }
        
        return [URLQueryItem(name: "api_key", value: "xfFhvZ3hFEJ9Ai5zYb35YR7f8JCF3Ei2huF5cCUC")]
    }
    
    func buildURLRequest(url: URL, request: HTTPRequestModelProtocol) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        let body = try buildBody(request: request)
        urlRequest.httpBody = body
        
        urlRequest = addHeaders(from: request, to: urlRequest)
        
        return urlRequest
    }
    
    func buildBody(request: HTTPRequestModelProtocol) throws -> Data? {
        guard let body = request.body else {
            return nil
        }
        
        do {
            return try JSONEncoder().encode(body)
        } catch {
            throw HTTPRequestBuilderError.invalidBody
        }
    }
    
    func addHeaders(from request: HTTPRequestModelProtocol, to urlRequest: URLRequest) -> URLRequest {
        var headers: [String: String] = [:]
        
        if let header = request.header {
            headers = header
        }
        
        var updatedURLRequest = urlRequest
        
        for (key, value) in headers {
            updatedURLRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return updatedURLRequest
    }
}

