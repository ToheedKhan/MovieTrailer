//
//  MovieCellViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

class MovieCellViewModel {
    
    //MARK:- Variable:-
    private let networkService = NetworkService()
    
    var posterImageUrl: String?
    var movieTitle: String?
    var releaseDate: String?
    //    var id: String?
    var rate: String?
    var voteCount: String?
    var popularity: String?
    var overview: String?
    
    init(){}
    
    init(
        posterImageUrl: String?,
        movieTitle: String?,
        releaseDate: String?,
        rate: String?,
        voteCount: String?,
        popularity: String?,
        overview: String?
    ){
        self.posterImageUrl = posterImageUrl
        self.movieTitle = movieTitle
        self.releaseDate = releaseDate
        self.rate = rate
        self.voteCount = voteCount
        self.popularity = popularity
        self.overview = overview 
    }
}
