//
//  MoviePresenterTest.swift
//  MovieAppTests
//
//  Created by Darya Dainiak on 5/14/21.
//

@testable import MovieApp
import XCTest

///
class MockNetworkService: NetworkServiceProtocol {
    var films: [Film]!

    init() {}

    convenience init(films: [Film]?) {
        self.init()
        self.films = films
    }

    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void) {
        if let films = films {
            completion(.success(films))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }

    func fetchDescription(id: Int32?, completion: @escaping (Result<FilmDetails?, Error>) -> Void) {}
}

///
class MovieViewModelTest: XCTestCase {
    var viewModel: MovieListViewModel!
    var networkService: NetworkServiceProtocol!
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
        networkService = nil
        viewModel = nil
    }

    func testGetSuccessMovies() {
        networkService = MockNetworkService(films: movieArray)
        viewModel = MovieListViewModel(networkService: networkService, type: type)

        var catchMovies: [Film]?

        networkService.fetchData(type: type, currentPage: currentPage) { result in
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
        networkService = MockNetworkService()
        viewModel = MovieListViewModel(networkService: networkService, type: type)

        var catchError: Error?

        networkService.fetchData(type: type, currentPage: currentPage) { result in
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
