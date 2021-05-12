//
//  NetworkService.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/11/21.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<FilmsApi, Error>) -> Void)
//    func fetchDescription(id: Int?, completion: @escaping (Result<FilmDetails?, Error>) -> Void)
}

///
class NetworkService: NetworkServiceProtocol {
    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<FilmsApi, Error>) -> Void) {
//        private func fetchData(type: String, currentPage: Int) {
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
                completion(.success(filmsApi))
            } catch {
                completion(.failure(error))
//                    DispatchQueue.main.async {
//                        self.errorLabel.isHidden = false
//                        self.moviesTableView.isHidden = true
//                        self.view.bringSubviewToFront(self.errorLabel)
//                    }
//                    print("Error serialization json \(error)", error.localizedDescription)
            }
        }.resume()
    }
}
