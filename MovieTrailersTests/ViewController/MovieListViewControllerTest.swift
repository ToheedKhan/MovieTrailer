//
//  MovieListViewControllerTest.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 01/07/22.
//

@testable import MovieTrailers
import XCTest

final class MovieListViewControllerTests: XCTestCase {
    
    var viewController : MovieListViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "\(MovieListViewController.self)")
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(viewController.tableView, "tableView")
        XCTAssertNotNil(viewController.alertView, "alertView")
    }
}
