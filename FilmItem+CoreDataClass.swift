//
//  FilmItem+CoreDataClass.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/13/21.
//
//

import CoreData
import Foundation

@objc(FilmItem)
public class FilmItem: NSManagedObject {
    static func make(from film: Film, in context: NSManagedObjectContext) -> FilmItem? {
        let filmItem = FilmItem(entity: entity(), insertInto: context)

        filmItem.filmId = film.filmId
        filmItem.nameRu = film.nameRu
        filmItem.posterUrlPreview = film.posterUrlPreview
        filmItem.rating = film.rating
        filmItem.year = film.year
        filmItem.genres = film.genres.map { $0.genre }
        filmItem.countries = film.countries.map { $0.country }

        return filmItem
    }
}
