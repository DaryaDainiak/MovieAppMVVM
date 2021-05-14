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
        
        //        for country in film.countries {
        //                let countryItem = CountryItem()
        //                countryItem.country = country.country
        //                filmItem.addToToCountries(countryItem)
        //            }
        
        //            for genre in film.genres {
        //                let genreItem = GenreItem()
        //                genreItem.genre = genre.genre
        //                filmItem.addToToGenres(genreItem)
        //            }
        
        return filmItem
    }
}
