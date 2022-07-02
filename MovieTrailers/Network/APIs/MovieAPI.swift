//
//  MovieAPI.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation
//https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=<your API key>)
//https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=4b28f1b5b501665aa814f87d10949151"
enum MovieAPI: Requestable {
    case getAllMovies
    
    var path: String {
        switch self {
        case .getAllMovies:
            return "/3/discover/movie"
        }
    }
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAllMovies:
            return [URLQueryItem(name: "sort_by", value: "popularity.desc"), URLQueryItem(name: "api_key", value: NetworkConstants.apiKey)]
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getAllMovies:
            return  .GET
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getAllMovies:
            return nil
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAllMovies:
            return nil
        }
    }
}


//extension MovieAPI {
//    
////    func getMoviesData() -> Promise<NearLocationsResponse> {
////        return fireRequestWithSingleResponse(requestable: APIRouter.getLocation(self, lat: lat, long: long))
////    }
//    
//    func getMoviesData(completion : @escaping (MovieList) -> ()){
//        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
//            if let data = data {
//                
//                let jsonDecoder = JSONDecoder()
//                
//                let empData = try! jsonDecoder.decode(Employees.self, from: data)
//                completion(empData)
//            }
//        }.resume()
//    }
//}

