//
//  MoviePresenterTest.swift
//  MovieAppTests
//
//  Created by Darya Dainiak on 5/14/21.
//

@testable import MovieApp
import XCTest

///
class MovieViewModelTest: XCTestCase {
    var viewModel: MovieListViewModel!
    var movieListUseCase: MovieListUseCaseProtocol!
    var type: String = ""
    var currentPage = 0
    var movieArray: [Film] = []

    override func setUpWithError() throws {
        let movie = Film(
            posterUrlPreview: "Foo",
            nameRu: "Baz",
            description: "Bar",
            genres: [],
            countries: [],
            year: "Foo",
            rating: "1",
            filmId: 2
        )
        movieArray.append(movie)
    }

    override func tearDownWithError() throws {
        movieListUseCase = nil
        viewModel = nil
    }

    func testGetSuccessMovies() {
        movieListUseCase = MockMovieListUseCase(films: movieArray)
        viewModel = MovieListViewModel(movieListUseCase: movieListUseCase, type: type)

        var catchMovies: [Film]?

        movieListUseCase.fetchData(type: type, currentPage: currentPage) { result in
            switch result {
            case let .success(films):
                catchMovies = films
            case let .failure(error):
                print(error)
            }
        }

        XCTAssertNotEqual(catchMovies?.count, 0)
        XCTAssertEqual(catchMovies?.count, 1)
    }

    func testGetErrorMovies() {
        movieListUseCase = MockMovieListUseCase()
        viewModel = MovieListViewModel(movieListUseCase: movieListUseCase, type: type)

        var catchError: Error?

        movieListUseCase.fetchData(type: type, currentPage: currentPage) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                catchError = error
            }
        }

        XCTAssertNotNil(catchError)
    }
}
