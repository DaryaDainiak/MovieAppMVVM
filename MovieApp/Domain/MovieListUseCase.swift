//
//  MovieListUseCase.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/17/21.
//

import Foundation
import UIKit

///
class MovieListUseCase: MovieListUseCaseProtocol {
    private let networkService: NetworkServiceProtocol
    private let coreDataService: CoreDataServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.coreDataService = coreDataService
        self.networkService = networkService
    }
    
    func fetchData(type: String, currentPage: Int, completion: @escaping (Result<[Film], Error>) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            let filmItems = coreDataService.getFilmItems()
            
            let films = filmItems.map { Film(from: $0) }.sorted(by: { $0.nameRu ?? "" < $1.nameRu ?? "" })
            
            completion(.success(films))
            return
        }
        
        networkService.fetchData(type: type, currentPage: currentPage) { [weak self] result in
            
            switch result {
            case let .success(films):
                let sortedFilms = films.sorted(by: { $0.nameRu ?? "" < $1.nameRu ?? "" })
                completion(.success(sortedFilms))
                
                DispatchQueue.main.async {
                    self?.coreDataService.save(films: sortedFilms)
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDescription(id: Int32?, completion: @escaping (Result<FilmDetails?, Error>) -> Void) {
        networkService.fetchDescription(id: id, completion: completion)
    }
}

// MARK: - Extension Film

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
