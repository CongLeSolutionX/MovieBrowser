//
//  MovieService.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import Combine

class MoviesService: MovieServiceType {
  
  var networkManager: NetworkManagerProvider
  var decoder: JSONDecoder
  
  init(
    networkManager: NetworkManagerProvider = NetworkManager(),
    decoder: JSONDecoder = JSONDecoder()
  ){
    self.networkManager = networkManager
    self.decoder = decoder
  }
  
  func getMovies(from url: String) -> AnyPublisher<[Movie], NetworkError> {
    guard let url = URL(string: url) else {
      return Fail(error: NetworkError.url).eraseToAnyPublisher()
    }
    
    return networkManager
      .get(from: url)
      .decode(type: MoviesResponse.self, decoder: decoder)
      .mapError { _ in NetworkError.decode }
      .map { $0.results }
      .eraseToAnyPublisher()
  }
  
  func getImage(from url: String) -> AnyPublisher<Data, NetworkError> {
    guard let url = URL(string: url) else {
      return Fail(error: NetworkError.url).eraseToAnyPublisher()
    }
    
    return networkManager
      .get(from: url)
      .eraseToAnyPublisher()
  }
  
  func searchMovie(from url: String) -> AnyPublisher<[Movie], NetworkError> {
    guard let url = URL(string: url) else {
      return Fail(error: NetworkError.url).eraseToAnyPublisher()
    }
    return networkManager
      .get(from: url)
      .mapError { NetworkError.other($0)}
      .decode(type: MoviesResponse.self, decoder: decoder)
      .mapError { error in
        if let error = error as? NetworkError {
          return error // unknown error
        }
        return NetworkError.decode
      }
      .map { $0.results}
      .eraseToAnyPublisher()
  }
}
