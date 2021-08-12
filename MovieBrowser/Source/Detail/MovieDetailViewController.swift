//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
  weak var coordinator: Coordinator?
  var idMovie: Int? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension MovieDetailViewController: Storyboarded { }
