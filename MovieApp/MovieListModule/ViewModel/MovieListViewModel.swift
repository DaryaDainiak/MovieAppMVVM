//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/11/21.
//

import Foundation

///
final class MovieListViewModel: MovieListViewModelProtocol {
    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol!

    // MARK: - Public Properties

    var currentPage = 1
    var type: String
    var movieArray: [Film] = []

    public var dataUpdated: (() -> ())?
    public var showError: ((Error) -> ())?

    // MARK: - Lifecycle

    required init(
        networkService: NetworkServiceProtocol,
        type: String
    ) {
//        self.view = view
        self.networkService = networkService
        self.type = type
    }

    // MARK: - Public Methods

    func numberOfRows() -> Int {
        return movieArray.count
    }

    func cellViewModel(for indexPath: IndexPath) -> MovieListCellViewModelProtocol? {
        let movie = movieArray[indexPath.row]
        return MovieListCellViewModel(movie: movie)
    }

    func getMovies(type: String, currentPage: Int) {
        networkService.fetchData(type: type, currentPage: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(filmsApi):
                let films = filmsApi.films
                self.movieArray.append(contentsOf: films)
//                DispatchQueue.main.async {
                self.dataUpdated?()
//                    self.view?.success()
//                }
            case let .failure(error):
//                DispatchQueue.main.async {
                self.showError?(error)
//                    self.view?.failure(error: error)
//                }
            }
        }
    }

    func tapOnMovie(movie: Film?) {
//        router?.showDetails(selectedMovie: movie)
    }
}
