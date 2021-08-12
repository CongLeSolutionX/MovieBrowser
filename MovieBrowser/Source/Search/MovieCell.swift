//
//  MovieCell.swift
//  MovieBrowser
//
//  Created by Cong Le on 8/12/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
  static let identifier = "MovieCell"
  
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var releaseDate: UILabel!
  
  @IBOutlet weak var rating: UILabel!
  
  func configureCell(title: String, releaseDate: String?, imageName: Data?, rating: Float) {
    movieTitle.text = title
    self.rating.text = String(rating)
    
    if let releaseDate = releaseDate {
      self.releaseDate.text = releaseDate
    }
    
    guard let imageName = imageName else {
      movieImageView.image = UIImage(named: "placeholder")
      return
    }
    
    movieImageView.image = UIImage(data: imageName)
  }
}
