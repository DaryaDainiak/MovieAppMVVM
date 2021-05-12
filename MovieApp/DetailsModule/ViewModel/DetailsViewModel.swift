//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/11/21.
//

import Foundation

protocol DetailsViewProtocol: AnyObject {
//    func success()
//    func failure(error: Error)
}

protocol DetailsViewModelProtocol: AnyObject {
    var dataUpdated: (() -> ())? { get set }
    var showError: ((Error) -> ())? { get set }
    var selectedMovie: Film? { get set }
    var movieDetails: FilmDetails? { get set }
    init(
        //        view: DetailsViewProtocol,
        networkService: NetworkServiceProtocol,
        selectedMovie: Film?
    )
    func getMovieDetails()
//    func tap()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Private Properties

//    private weak var view: DetailsViewProtocol?
    private let networkService: NetworkServiceProtocol!

    // MARK: - Public Properties

    var selectedMovie: Film?
    var movieDetails: FilmDetails?
//    var title: String {
//        return selectedMovie?.nameRu ?? ""
//    }

    public var dataUpdated: (() -> ())?
    public var showError: ((Error) -> ())?

    // MARK: - Lifecycle

    init(
        networkService: NetworkServiceProtocol,
        selectedMovie: Film?
    ) {
        self.networkService = networkService
        self.selectedMovie = selectedMovie
    }

    // MARK: - Public Methods

//    func getImage() -> String {
//        return selectedMovie?.posterUrlPreview ?? ""
//    }
//    func getTitle() -> String {
//        return selectedMovie?.nameRu ?? ""
//    }

    func getMovieDetails() {
        networkService.fetchDescription(id: selectedMovie?.filmId) { [weak self] result in
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

//    func tap() {
//        router?.popToRoot()
//    }
}
