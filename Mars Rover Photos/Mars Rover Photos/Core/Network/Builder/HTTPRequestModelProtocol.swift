//
//  HTTPRequestModelProtocol.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

protocol HTTPRequestModelProtocol {
    var method: HTTPMethod { get }
    var path: HTTPPath { get }
    var query: [String: String]? { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
}
