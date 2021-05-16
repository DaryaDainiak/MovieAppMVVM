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
class NetworkService: NetworkServiceProtocol {
    let coreDataService = CoreDataService()

    init() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else {
            return
        }
        let sceneDelegate = windowScene.delegate as? SceneDelegate
        coreDataService.managedContext = sceneDelegate?.coreDataStack.persistentContainer.viewContext
    }

    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            let filmItems = coreDataService.getFilmItems()
            let films = filmItems.map { Film(from: $0) }.sorted(by: { $0.nameRu ?? "" < $1.nameRu ?? "" })
            completion(.success(films))
            return
        }

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

                let sortedFilms = filmsApi.films.sorted(by: { $0.nameRu ?? "" < $1.nameRu ?? "" })

                completion(.success(sortedFilms))
                DispatchQueue.main.async {
                    self.coreDataService.save(films: sortedFilms)
                }
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

private extension Film {
    init(from filmItem: FilmItem) {
        self.init(
            posterUrlPreview: filmItem.posterUrlPreview ?? "",
            nameRu: filmItem.nameRu,
            description: filmItem.description,
            genres: filmItem.genres?.map { Genre(genre: $0) } ?? [],
            countries: filmItem.countries?.map { Country(country: $0) } ?? [],
            year: filmItem.year ?? "",
            rating: filmItem.rating ?? "",
            filmId: filmItem.filmId
        )
    }
}
