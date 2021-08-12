//
//  Coordinator.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  func start()
  func showMovieDetail(idMovie: Int)
}
