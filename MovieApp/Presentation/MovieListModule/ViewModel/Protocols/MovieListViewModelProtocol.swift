//
//  MovieListViewModelProtocol.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    var dataUpdated: (() -> ())? { get set }
    var showError: ((Error) -> ())? { get set }
    var movieArray: [Film] { get set }
    var currentPage: Int { get set }
    var type: String { get set }
    var goToDetails: ((Film) -> ())? { get }

    init(
        movieListUseCase: MovieListUseCaseProtocol,
        type: String
    )
    func numberOfRows() -> Int
    func cellViewModel(for indexPath: IndexPath) -> MovieListCellViewModelProtocol?

    func viewModelForSelectedRow() -> DetailsViewModelProtocol?
    func selectedRow(atIndexPath indexPath: IndexPath)

    func getMovies(type: String, currentPage: Int)
    func tapOnMovie(movie: Film?)
}
