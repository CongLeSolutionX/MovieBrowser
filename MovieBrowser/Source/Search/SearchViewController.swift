//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
  weak var coordinator: Coordinator?
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  private let movieViewModel = MovieViewModel()
  
  private var publishers = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Search Movies"
    navigationItem.largeTitleDisplayMode = .always
    setupBinding()
  }
}

extension SearchViewController: Storyboarded {}

// MARK: - Helper methods
extension SearchViewController {
  
  private func setupBinding() {
    
    // binding movies
    movieViewModel
      .moviesBinding
      .sink { [weak self] in
        self?.tableView.reloadData()
      }
      .store(in: &publishers)
    
    // binding error
    movieViewModel
      .errorBinding
      .dropFirst()
      .sink { [weak self] message in
        self?.showAlertError(with: message)
      }
      .store(in: &publishers)
    
    // binding images
    movieViewModel
      .$updateRow
      .dropFirst()
      .sink { _ in }
        receiveValue: { [weak self] row in
          self?.tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
        }
      .store(in: &publishers)
    
    // fetching data
    movieViewModel.loadMovies()
  }
  
  private func showAlertError(with errorMessage: String) {
    let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
    let acceptAction = UIAlertAction(title: "Accept", style: .default)
    alert.addAction(acceptAction)
    present(alert, animated: true)
  }
}
// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let idMovie = movieViewModel.movies[indexPath.row].id
    coordinator?.showMovieDetail(idMovie: idMovie)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 175.0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieViewModel.numberOfMovies
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
      return UITableViewCell() // default tableView cell
    }
    let row = indexPath.row
    let title = movieViewModel.titleMovie(at: row)
    let image = movieViewModel.loadImageMovie(at: row)
    let releaseDate = movieViewModel.releaseDate(at: row)
    let rating = movieViewModel.rating(at: row)
    cell.configureCell(title: title, releaseDate: releaseDate, imageName: image, rating: rating)
    return cell
  }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    movieViewModel.searchMovies(by: searchText)
  }
}
