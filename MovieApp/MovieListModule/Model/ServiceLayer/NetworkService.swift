//
//  NetworkService.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/11/21.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void)
    func fetchDescription(id: Int32?, completion: @escaping (Result<FilmDetails?, Error>) -> Void)
}

///
final class NetworkService: NetworkServiceProtocol {
    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void) {
        let urlString =
            "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=\(type)&page=\(currentPage)"
        let components = URLComponents(string: urlString)
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": "36d1910f-1de8-413f-89dc-665968e24647"]
        URLSession.shared.dataTask(with: request) { data, _, error in

            guard let data = data else { return }
            do {
                let filmsApi = try JSONDecoder().decode(FilmsApi.self, from: data)
                completion(.success(filmsApi.films))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchDescription(id: Int32?, completion: @escaping (Result<FilmDetails?, Error>) -> Void) {
        guard let id = id else { return }
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/\(id)"
        let components = URLComponents(string: urlString)
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": "36d1910f-1de8-413f-89dc-665968e24647"]
        URLSession.shared.dataTask(with: request) { data, _, error in

            guard let data = data
            else { return }
            do {
                let filmDetails = try JSONDecoder().decode(FilmDetails.self, from: data)
                completion(.success(filmDetails))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
