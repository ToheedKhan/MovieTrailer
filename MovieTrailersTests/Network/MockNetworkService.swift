//
//  MockAPIService.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 01/07/22.
//

import XCTest
@testable import MovieTrailers


class MockNetworkService: NetworkServiceProtocol {
    
    var isFetchMoviesCalled = false
    
    var completeMovies: MovieList = MovieList()
    var completeClosure: ((RequestResult<MovieList>) -> Void) = {_ in }
    
    func sendRequest<SuccessModel: Decodable>(
        urlRequest: URLRequest,
        successModel: SuccessModel.Type,
        completion: @escaping (RequestResult<SuccessModel>) -> Void
    ) {
        isFetchMoviesCalled = true
//        completeClosure = ((RequestResult<MovieList>) -> Void)
    }
    
    func fetchSuccess() {
        completeClosure(.success(completeMovies) )
    }
    
    func fetchFail(error: Error?) {
        completeClosure( .failure("Something went wrong!!!") )
    }
    
}

class StubGenerator {
    func stubMovies() -> MovieList {
        let testBundle = Bundle(for: type(of: self))
        
        let filePath = testBundle.path(forResource: "movie_data", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let movieList = try! decoder.decode(MovieList.self, from: data)
        return movieList
    }
}
