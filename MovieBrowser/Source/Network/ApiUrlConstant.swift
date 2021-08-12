//
//  ApiConstant.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//
/// Resources:
/// For searching movie: https://developers.themoviedb.org/3/search/search-movies
/// For image: https://developers.themoviedb.org/3/getting-started/images
/// For detail of each movie: https://developers.themoviedb.org/3/movies/get-movie-details
import Foundation
enum ApiUrlConstant {
  static private let apiKey = "?api_key=5885c445eab51c7004916b9c0313e2d3"
  static private let base = "https://api.themoviedb.org/3"
  static private let language = "&language=en-US"
  static private let query = "&query=\(queryKey)"
  static let queryKey = "$QUERY$"
  static let movies = "\(base)/movie/popular\(apiKey)\(language)"
  static let searchMovies = "\(base)/search/movie\(apiKey)\(language)\(query)"
  static let imageBase = "https://image.tmdb.org/t/p/w500"
  static let detailMovie = "\(base)/movie/497698\(apiKey)\(language)" // need update the idMovie
}
