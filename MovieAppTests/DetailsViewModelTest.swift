//
//  DetailsViewModelTest.swift
//  MovieAppTests
//
//  Created by Darya Dainiak on 5/15/21.
//

@testable import MovieApp
import XCTest

///
class MockDetailsNetworkService: NetworkServiceProtocol {
    var filmDetails: FilmDetails!

    init() {}

    convenience init(filmDetails: FilmDetails?) {
        self.init()
        self.filmDetails = filmDetails
    }

    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void) {}

    func fetchDescription(id: Int32?, completion: @escaping (Result<FilmDetails?, Error>) -> Void) {
        if let filmDetails = filmDetails {
            completion(.success(filmDetails))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

///
class DetailsViewModelTest: XCTestCase {
    var viewModel: DetailsViewModel!
    var networkService: NetworkServiceProtocol!
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
        networkService = nil
        viewModel = nil
    }

    func testGetSuccessFilmDetails() {
        let filmDetails = FilmDetails(data: DataClass(description: "Foo"))
        var catchFilmDetails: FilmDetails?

        networkService = MockDetailsNetworkService(filmDetails: filmDetails)
        viewModel = DetailsViewModel(networkService: networkService, selectedMovie: selectedMovie)

        networkService.fetchDescription(id: selectedMovie?.filmId) { result in
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

        networkService = MockDetailsNetworkService()
        viewModel = DetailsViewModel(networkService: networkService, selectedMovie: selectedMovie)

        networkService.fetchDescription(id: selectedMovie?.filmId) { result in
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
