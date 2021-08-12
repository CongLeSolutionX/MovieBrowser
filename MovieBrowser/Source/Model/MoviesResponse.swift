//
//  Movie.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//
// Resources: https://developers.themoviedb.org/3/getting-started/search-and-query-for-details

import Foundation

struct MoviesResponse: Decodable {
  let page: Int
  let results: [Movie]
}

//MARK: - Movie
struct Movie: Decodable {
  let id: Int
  let posterPath: String?
  let overview: String
  let originalTitle: String
  let releaseDate: String?
  let voteAverage: Float
  
  private enum CodingKeys: String, CodingKey {
    case id
    case overview
    case posterPath = "poster_path"
    case voteAverage = "vote_average"
    case originalTitle = "original_title"
    case releaseDate = "release_date"
  }
}
