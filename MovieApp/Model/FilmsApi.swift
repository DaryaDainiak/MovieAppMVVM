//
//  MovieCard.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 08.03.2021.
//

import Foundation

/// FilmsApi
struct FilmsApi: Decodable {
    let pagesCount: Int
    let films: [Film]
}

/// Film
struct Film: Decodable {
    let posterUrlPreview: String
    let nameRu: String?
    let description: String?
    let genres: [Genre]
    let countries: [Country]
    let year: String
    let rating: String
    let filmId: Int
}

/// Genre
struct Genre: Decodable {
    let genre: String
}

/// Country
struct Country: Decodable {
    let country: String
}
