//
//  HTTPRequestModel.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

struct HTTPRequestModel: HTTPRequestModelProtocol {
    var method: HTTPMethod
    var path: HTTPPath
    var query: [String: String]?
    var header: [String: String]?
    var body: Encodable?
}
