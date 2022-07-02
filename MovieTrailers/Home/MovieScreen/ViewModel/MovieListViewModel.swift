//
//  MovieListViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

class MovieListViewModel {
    
    //MARK:- Variable & Constants:-
    let networkService: NetworkServiceProtocol

    var cellViewModels: [MovieCellViewModel] = [MovieCellViewModel]()
    var moviesList :(([MovieCellViewModel])->())!
    var loading :((Bool) ->())!
    var error: ((String)-> ())!
    var isFetch = false
    var isRefresh: ((Bool) -> ())!
    
    init( networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getMovies() {
        self.requestItems { [self] model, error in
            var list = [MovieCellViewModel]()
            if let movies = model {
                for movie in movies.results {
                    list.append(self.createCellViewModel(from: movie))
                }
                self.cellViewModels = list
                
                self.moviesList(self.cellViewModels)
                
            } else {
                self.error(error ?? "")
            }
            self.loading(false)
            self.isRefresh(false)
            self.isFetch = false
        }
    }
   
    //MARK:- NetWork
    func requestItems(completion: @escaping (MovieList?, String?) -> Void) {
        if !isFetch { self.loading?(true) }
        
        networkService.sendRequest(
            urlRequest: MovieAPI.getAllMovies.createURLRequest(),
            successModel: MovieList.self
        ) { [weak self] (result) in
            guard self != nil else {return}
            switch result {
            case .success(let model):
                completion(model, nil)
            case .badRequest(let error):
                completion(nil, error.errors?.first)
                debugPrint(#function, error)
            case .failure(let error):
                completion(nil, error)
                debugPrint(#function, error)
            }
        }
    }
    
    //MARK:- Setup Cell View Model

    
    //MARK:- Create Cell View Model
    func createCellViewModel(from result: Movie) -> MovieCellViewModel {
        return MovieCellViewModel(posterImageUrl: (NetworkConstants.BASE_IMAGE_URL + result.posterPath), movieTitle: result.title, releaseDate: result.releaseDate, rate: String(describing: result.voteAverage), voteCount: String(describing: result.voteCount), popularity: String(describing: result.popularity), overview: result.overview)
    }

}
