//
//  NetworkManager.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import Combine

class NetworkManager {
  private let session = URLSession.shared
}

extension NetworkManager: NetworkManagerProvider {
  func get(from url: URL) -> AnyPublisher<Data, NetworkError> {
    session
      .dataTaskPublisher(for: url)
      .tryMap { request in
        guard let httpResponse = request.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw NetworkError.data
        }
        return request.data
      }
      .mapError { error in
        NetworkError.other(error)
      }
      .eraseToAnyPublisher()
  }
}
