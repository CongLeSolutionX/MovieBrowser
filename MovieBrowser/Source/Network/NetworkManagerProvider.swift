//
//  NetworkManagerType.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import Combine

protocol NetworkManagerProvider {
  func get(from url: URL) -> AnyPublisher<Data, NetworkError>
}
