//
//  MovieList.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

struct MovieList: Decodable {
    var results: [Movie]
    
    init() {
        results = []
    }
}
