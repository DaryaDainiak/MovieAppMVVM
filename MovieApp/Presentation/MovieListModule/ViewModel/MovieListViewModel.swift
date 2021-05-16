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
    private var selectedIndexPath: IndexPath?

    // MARK: - Public Properties

    var currentPage = 1
    var type: String
    var movieArray: [Film] = []

    public var dataUpdated: (() -> ())?
    public var showError: ((Error) -> ())?
    public var goToDetails: ((Film) -> ())?

    // MARK: - Lifecycle

    required init(
        networkService: NetworkServiceProtocol,
        type: String
    ) {
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

    func viewModelForSelectedRow() -> DetailsViewModelProtocol? {
        guard let path = selectedIndexPath?.row else { return nil }
        return DetailsViewModel(networkService: networkService, selectedMovie: movieArray[path])
    }

    func selectedRow(atIndexPath indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }

    func getMovies(type: String, currentPage: Int) {
        networkService.fetchData(type: type, currentPage: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(films):
                let films = films
                self.movieArray.append(contentsOf: films)
                self.dataUpdated?()
            case let .failure(error):
                self.showError?(error)
            }
        }
    }

    func tapOnMovie(movie: Film?) {
//        router?.showDetails(selectedMovie: movie)
    }
}
