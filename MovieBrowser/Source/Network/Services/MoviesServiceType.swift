//
//  MoviesServiceType.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import  Combine

protocol MovieServiceType {
  var networkManager: NetworkManagerProvider { get }
  var decoder: JSONDecoder { get }
  func getMovies(from url: String) -> AnyPublisher<[Movie], NetworkError>
}
