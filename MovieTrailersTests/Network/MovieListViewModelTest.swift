//
//  MovieListViewModelTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 01/07/22.
//

import XCTest
@testable import MovieTrailers

class MovieListViewModelTest: XCTestCase {
    
    var movieListViewModel: MovieListViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        movieListViewModel = MovieListViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        movieListViewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchMovie() {
        // Given
        mockNetworkService.completeMovies = StubGenerator().stubMovies()
        // When
        movieListViewModel.getMovies()

        // Assert
        XCTAssert(mockNetworkService!.isFetchMoviesCalled)
    }
    
    func testFetchMovieFail() {

        // Given a failed fetch with a certain failure
        let error = NetworkErrors.badRequest

        // When
        movieListViewModel.getMovies()

        mockNetworkService.fetchFail(error: error )
        movieListViewModel.error = {  error in
            guard !error.isEmpty else {
                return
            }
            // movieListViewModel should display predefined error message

            XCTAssertEqual( error, error)
        }

    }

    func testCreateCellViewModel() {
        // Given
        let movies = StubGenerator().stubMovies()
        mockNetworkService.completeMovies = movies
        let expect = XCTestExpectation(description: "loading closure triggered")
        movieListViewModel.loading = { isLoading in
            expect.fulfill()
        }

        // When
        movieListViewModel.getMovies()
        mockNetworkService.fetchSuccess()
        for movie in movies.results {
            movieListViewModel.cellViewModels.append(movieListViewModel.createCellViewModel(from: movie))
        }

        // Number of cell view model is equal to the number of movies
        XCTAssertEqual( movieListViewModel.cellViewModels.count, movies.results.count )

        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)

    }

    func testCellViewModel() {
        //Given movie
        let movie = Movie(popularity: 10084.004, voteCount: 3728, id: 453395, voteAverage: 7.6, title: "Doctor Strange in the Multiverse of Madness", posterPath: "/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg", originalLanguage: "en", originalTitle: "Doctor Strange in the Multiverse of Madness", adult: false, overview: "Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.", releaseDate: "2022-05-04")
       

        // When creat cell view model
        let cellViewModel = movieListViewModel.createCellViewModel( from: movie )
        
        // Assert the correctness of display information
        XCTAssertEqual( movie.title, cellViewModel.movieTitle )
        XCTAssertEqual( String(describing: movie.popularity), cellViewModel.popularity )
        XCTAssertEqual( String(describing: movie.releaseDate), cellViewModel.releaseDate )

        XCTAssertEqual( String(describing: movie.voteAverage), cellViewModel.rate )
        XCTAssertEqual( String(describing: movie.voteCount), cellViewModel.voteCount )
    }
}

