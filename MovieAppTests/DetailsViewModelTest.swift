//
//  DetailsViewModelTest.swift
//  MovieAppTests
//
//  Created by Darya Dainiak on 5/15/21.
//

@testable import MovieApp
import XCTest

///
class DetailsViewModelTest: XCTestCase {
    var viewModel: DetailsViewModel!
    var movieListUseCase: MovieListUseCaseProtocol!
    var id = 0
    var selectedMovie: Film?

    override func setUpWithError() throws {
        let selectedFilm = Film(
            posterUrlPreview: "Foo",
            nameRu: "Baz",
            description: "Bar",
            genres: [],
            countries: [],
            year: "Foo",
            rating: "1",
            filmId: 2
        )
        selectedMovie = selectedFilm
    }

    override func tearDownWithError() throws {
        movieListUseCase = nil
        viewModel = nil
    }

    func testGetSuccessFilmDetails() {
        let filmDetails = FilmDetails(data: DataClass(description: "Foo"))
        var catchFilmDetails: FilmDetails?

        movieListUseCase = MockMovieListUseCase(filmDetails: filmDetails)
        viewModel = DetailsViewModel(movieListUseCase: movieListUseCase, selectedMovie: selectedMovie)

        movieListUseCase.fetchDescription(id: selectedMovie?.filmId) { result in
            switch result {
            case let .success(details):
                catchFilmDetails = details
            case let .failure(error):
                print(error)
            }
        }

        XCTAssertNotNil(catchFilmDetails)
    }

    func testGetErrorFilmDetails() {
        var catchError: Error?

        movieListUseCase = MockMovieListUseCase()
        viewModel = DetailsViewModel(movieListUseCase: movieListUseCase, selectedMovie: selectedMovie)

        movieListUseCase.fetchDescription(id: selectedMovie?.filmId) { result in
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
