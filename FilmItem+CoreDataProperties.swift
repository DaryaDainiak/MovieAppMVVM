//
//  FilmItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/14/21.
//
//

import CoreData
import Foundation

///
public extension FilmItem {
    @nonobjc class func fetchRequest() -> NSFetchRequest<FilmItem> {
        return NSFetchRequest<FilmItem>(entityName: "FilmItem")
    }

    @NSManaged var filmId: Int32
    @NSManaged var genres: [String]?
    @NSManaged var nameRu: String?
    @NSManaged var posterUrlPreview: String?
    @NSManaged var rating: String?
    @NSManaged var year: String?
    @NSManaged var countries: [String]?
    @NSManaged var genre: NSSet?
    @NSManaged var country: NSSet?
}

// MARK: Generated accessors for genre

///
public extension FilmItem {
    @objc(addGenreObject:)
    @NSManaged func addToGenre(_ value: GenreItem)

    @objc(removeGenreObject:)
    @NSManaged func removeFromGenre(_ value: GenreItem)

    @objc(addGenre:)
    @NSManaged func addToGenre(_ values: NSSet)

    @objc(removeGenre:)
    @NSManaged func removeFromGenre(_ values: NSSet)
}

// MARK: Generated accessors for country

///
public extension FilmItem {
    @objc(addCountryObject:)
    @NSManaged func addToCountry(_ value: CountryItem)

    @objc(removeCountryObject:)
    @NSManaged func removeFromCountry(_ value: CountryItem)

    @objc(addCountry:)
    @NSManaged func addToCountry(_ values: NSSet)

    @objc(removeCountry:)
    @NSManaged func removeFromCountry(_ values: NSSet)
}

extension FilmItem: Identifiable {}
