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
  
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var releaseDate: UILabel!
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var movieDescription: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension MovieDetailViewController: Storyboarded { }
