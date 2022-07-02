//
//  NetworkErrors.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

enum NetworkErrors: Error {
    case badRequest
    case unauthorized
}

enum StatusCode: Int {
    case okey = 200
    case badRequest = 400
}
