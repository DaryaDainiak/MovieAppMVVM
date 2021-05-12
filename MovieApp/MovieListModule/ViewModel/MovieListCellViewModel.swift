//
//  MovieListCellViewModel.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import Foundation

///
class MovieListCellViewModel: MovieListCellViewModelProtocol {
    private var movie: Film

    var image: String {
        return String(describing: movie.posterUrlPreview)
    }

    var title: String {
        return String(describing: movie.nameRu)
    }

    var genres: String {
        var genres: String = ""
        for index in 0 ..< movie.genres.count {
            genres += movie.genres[index].genre
            if index < movie.genres.count - 1 {
                genres += ", "
            }
        }
        return "Жанр: \(genres)"
    }

    var countries: String {
        var countries: String = ""
        for index in 0 ..< movie.countries.count {
            countries += movie.countries[index].country
            if index < movie.countries.count - 1 {
                countries += ", "
            }
        }
        return "Страны: \(countries)"
    }

    var rating: String {
        return String(describing: movie.rating)
    }

    init(movie: Film) {
        self.movie = movie
    }
}
