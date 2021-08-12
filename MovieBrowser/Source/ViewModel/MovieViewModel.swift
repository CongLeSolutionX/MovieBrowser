//
//  MovieViewModel.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import Combine

class MovieViewModel {
  var moviesBinding = PassthroughSubject<Void, Never>()
  
  var errorBinding: Published<String>.Publisher { $errorDescription }
  @Published private var errorDescription = ""
  
  private (set) var movies = [Movie]()
  
  @Published var updateRow = 0
  
  private let service: MoviesService
  
  private var imageCache = NSCache<NSString, NSData>()
  private var imagePublishers = [NSString: AnyCancellable]()
  
  private var publishers = Set<AnyCancellable>()
  
  init(service: MoviesService = MoviesService()) {
    self.service = service
  }
}
// MARK: - Business logics
extension MovieViewModel {
  var numberOfMovies: Int { movies.count }
  
  func titleMovie(at row: Int) -> String {
    return movies[row].originalTitle
  }
  
  func releaseDate(at row: Int) -> String {
    return movies[row].releaseDate ?? ""
  }
  
  func rating(at row: Int) -> Float {
    return movies[row].voteAverage
  }
  
  func loadMovies() {
    service
      .getMovies(from: ApiUrlConstant.movies)
      .receive(on: RunLoop.main)
      .sink { [weak self] completionBlock in
        switch completionBlock {
        case .finished:
          break
        case .failure(let error):
          self?.errorDescription = error.localizedDescription
        }
      } receiveValue: { [weak self] movies in
        self?.movies = movies
        self?.moviesBinding.send()
      }
      .store(in: &publishers)
  }
  
  func loadImageMovie(at row: Int) -> Data? {
    guard let posterpath = movies[row].posterPath else {  return nil }
    
    let key = NSString(string: posterpath)
    
    guard let dataCache = imageCache.object(forKey: key) else {
      downloadImageForTheFirstTime(at: row, key: key)
      return nil
    }
    return dataCache as Data
  }
  
  private func downloadImageForTheFirstTime(at row: Int, key: NSString) {
    if let url = movies[row].posterPath {
      // start download image
      let imageUrl = "\(ApiUrlConstant.imageBase)\(url)"
      let imagePublisher = service
        .getImage(from: imageUrl)
        .receive(on: RunLoop.main)
        .sink { _ in
        } receiveValue: { [weak self] data in
          let newData = NSData(data: data)
          self?.imageCache.setObject(newData, forKey: key)
          if row < (self?.movies.count ?? 0) {
            self?.updateRow = row
          }
        }
      // cancel the old publisher if calling the same row
      if let publisher = imagePublishers[key] {
        publisher.cancel()
      } else {
        imagePublishers[key] = imagePublisher
      }
    }
  }
  
  func searchMovies(by searchText: String) {
    if searchText.isEmpty {
      loadMovies()
      return
    }
    
    // creating new url
    guard let newUrl = ApiUrlConstant
            .searchMovies
            .replacingOccurrences(of: ApiUrlConstant.queryKey, with: searchText)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    else { return }
    
    service
      .searchMovie(from: newUrl)
      .receive(on: RunLoop.main)
      .sink { [weak self] completionBlock in
        switch completionBlock {
        case .finished:
          break
        case .failure(let error):
          self?.errorDescription = error.localizedDescription
        }
      } receiveValue: { [weak self] movies in
        self?.movies = movies
        self?.moviesBinding.send()
      }
      .store(in: &publishers)
  }
}
