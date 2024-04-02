//
//  HTTPRequest.swift
//  Mars Rover Photos
//
//  Created by Anton Kasaryn on 2.04.24.
//

enum HTTPRequest {
    case getRovers
    case getRoverPhotos(rover: String, camera: String?, date: String, page: Int)
    
    var request: HTTPRequestModelProtocol {
        switch self {
        case .getRovers:
            return HTTPRequestModel(method: .get, path: .rovers)
        case .getRoverPhotos(let rover, let camera, let date, let page):
            var query: [String: String] = [:]
            query["earth_date"] = date
            query["page"] = String(page)
            if let camera = camera {
                query["camera"] = camera
            }
            return HTTPRequestModel(method: .get, path: .rover(rover: rover), query: query)
        }
    }
}
