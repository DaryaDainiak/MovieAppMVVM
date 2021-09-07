//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/11/21.
//

import Foundation

protocol DetailsViewProtocol: AnyObject {}

protocol DetailsViewModelProtocol: AnyObject {
    var dataUpdated: (() -> ())? { get set }
    var showError: ((Error) -> ())? { get set }
    var selectedMovie: Film? { get set }
    var movieDetails: FilmDetails? { get set }
    init(
        movieListUseCase: MovieListUseCaseProtocol,
        selectedMovie: Film?
    )
    func getMovieDetails()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Private Properties

    private let movieListUseCase: MovieListUseCaseProtocol

    // MARK: - Public Properties

    var selectedMovie: Film?
    var movieDetails: FilmDetails?
    public var dataUpdated: (() -> ())?
    public var showError: ((Error) -> ())?

    // MARK: - Lifecycle

    init(
        movieListUseCase: MovieListUseCaseProtocol,
        selectedMovie: Film?
    ) {
        self.movieListUseCase = movieListUseCase
        self.selectedMovie = selectedMovie
    }

    // MARK: - Public Methods

    func getMovieDetails() {
        movieListUseCase.fetchDescription(id: selectedMovie?.filmId) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(filmDetails):
                    self.movieDetails = filmDetails
                    self.dataUpdated?()
                case let .failure(error):
                    self.showError?(error)
                }
            }
        }
    }
}
