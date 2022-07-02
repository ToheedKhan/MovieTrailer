//
//  MainCordinator.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var naviagtionController: UINavigationController
    
    func start() {
        let movieListVC = MovieListViewController.instatiate(StoryboardName.main)
        self.naviagtionController.pushViewController(movieListVC, animated: false)
    }
    
    init(naviagtionController: UINavigationController){
        self.naviagtionController = naviagtionController
        self.naviagtionController.navigationBar.isHidden = true
    }
    
}
