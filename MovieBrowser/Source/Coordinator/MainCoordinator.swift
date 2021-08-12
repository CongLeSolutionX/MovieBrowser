//
//  MainCoordinator.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    // create the first view controller
    let moviesList = SearchViewController.instantiate()
    moviesList.coordinator = self
    navigationController.pushViewController(moviesList, animated: true)
  }
  
  func showMovieDetail(idMovie: Int) {
    let detail = MovieDetailViewController.instantiate()
    detail.coordinator = self
    detail.idMovie = idMovie
    navigationController.pushViewController(detail, animated: true)
  }
}
