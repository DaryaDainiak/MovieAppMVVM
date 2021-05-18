//
//  MovieListUseCaseProtocol.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/17/21.
//

import Foundation

///
protocol MovieListUseCaseProtocol {
    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void)
    
    func fetchDescription(id: Int32?, completion: @escaping (Result<FilmDetails?, Error>) -> Void)
}
