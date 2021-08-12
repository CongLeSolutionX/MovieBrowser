//
//  NetworkError.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

enum NetworkError: Error  {
  case url
  case data
  case decode
  case other(Error)
}

extension NetworkError: LocalizedError {
  var localizedDescription: String {
    switch self {
    case .url:
      return NSLocalizedString("URL Failure, failed to convert to a URL", comment: "URL Failure")
    case .data:
      return NSLocalizedString("Data Corruption, the data is corrupted or could not be found", comment: "Data Corruption")
    case .decode:
      return NSLocalizedString("Decode Failure, failed to decode to model", comment: "Decode Failure")
    case .other(let error):
      return NSLocalizedString(error.localizedDescription, comment: "Other Error")
    }
  }
}
