//
//  MovieDetailViewModel.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 30/06/22.
//

import Foundation

class MovieDetailViewModel {
    var posterImageUrl: String?
    var overview: String?
    var movieTitle: String?
    
    init(movie: MovieCellViewModel) {
        self.posterImageUrl = (movie.posterImageUrl ?? "")
        self.overview = movie.overview ?? ""
        self.movieTitle = movie.movieTitle ?? ""
    }
}
