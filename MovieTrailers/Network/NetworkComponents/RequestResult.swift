//
//  RequestResult.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

enum RequestResult<Success> {
    case success(Success)
    case badRequest(FailureModel)
    case failure(String)
}

struct FailureModel: Codable {
    let statusCode: Int?
    let errors: [String]?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case errors
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try? values.decodeIfPresent(Int.self, forKey: .statusCode)
        errors = try? values.decodeIfPresent([String].self, forKey: .errors)
    }
}
