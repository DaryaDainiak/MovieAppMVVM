//
//  MockMovieListUseCase.swift
//  MovieAppTests
//
//  Created by Aliaksandr Dainiak on 5/17/21.
//
@testable import MovieApp
import UIKit

///
class MockMovieListUseCase: MovieListUseCaseProtocol {
    var films: [Film]!
    var filmDetails: FilmDetails!

    init() {}

    convenience init(films: [Film]?) {
        self.init()
        self.films = films
    }

    convenience init(filmDetails: FilmDetails?) {
        self.init()
        self.filmDetails = filmDetails
    }

    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void) {
        if let films = films {
            completion(.success(films))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }

    func fetchDescription(id: Int32?, completion: @escaping (Result<FilmDetails?, Error>) -> Void) {
        if let filmDetails = filmDetails {
            completion(.success(filmDetails))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}
