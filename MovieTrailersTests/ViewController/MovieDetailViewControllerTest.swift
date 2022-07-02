//
//  MovieDetailViewController.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 01/07/22.
//

@testable import MovieTrailers
import XCTest

final class MovieDetailViewControllerTests: XCTestCase {
    
    var viewController : MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "\(MovieDetailViewController.self)")
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(viewController.movieOverview, "movieOverview")
        XCTAssertNotNil(viewController.posterImageView, "posterImageView")
    }
}
