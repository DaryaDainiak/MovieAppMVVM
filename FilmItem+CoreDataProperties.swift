//
//  FilmItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/13/21.
//
//

import CoreData
import Foundation

///
public extension FilmItem {
    @nonobjc class func fetchRequest() -> NSFetchRequest<FilmItem> {
        return NSFetchRequest<FilmItem>(entityName: "FilmItem")
    }

    @NSManaged var countries: [Int]?
    @NSManaged var filmId: Int64
    @NSManaged var genres: [Int]?
    @NSManaged var nameRu: String?
    @NSManaged var posterUrlPreview: Data?
    @NSManaged var rating: String?
    @NSManaged var year: String?
    @NSManaged var toGenres: NSSet?
    @NSManaged var toCountries: NSSet?
}

// MARK: Generated accessors for toGenres

///
public extension FilmItem {
    @objc(addToGenresObject:)
    @NSManaged func addToToGenres(_ value: GenreItem)

    @objc(removeToGenresObject:)
    @NSManaged func removeFromToGenres(_ value: GenreItem)

    @objc(addToGenres:)
    @NSManaged func addToToGenres(_ values: NSSet)

    @objc(removeToGenres:)
    @NSManaged func removeFromToGenres(_ values: NSSet)
}

// MARK: Generated accessors for toCountries

///
public extension FilmItem {
    @objc(addToCountriesObject:)
    @NSManaged func addToToCountries(_ value: CountryItem)

    @objc(removeToCountriesObject:)
    @NSManaged func removeFromToCountries(_ value: CountryItem)

    @objc(addToCountries:)
    @NSManaged func addToToCountries(_ values: NSSet)

    @objc(removeToCountries:)
    @NSManaged func removeFromToCountries(_ values: NSSet)
}

extension FilmItem: Identifiable {}
