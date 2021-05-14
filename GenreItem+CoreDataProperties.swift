//
//  GenreItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/14/21.
//
//

import CoreData
import Foundation

///
public extension GenreItem {
    @nonobjc class func fetchRequest() -> NSFetchRequest<GenreItem> {
        return NSFetchRequest<GenreItem>(entityName: "GenreItem")
    }

    @NSManaged var genres: String?
    @NSManaged var film: NSSet?
}

// MARK: Generated accessors for film

///
public extension GenreItem {
    @objc(addFilmObject:)
    @NSManaged func addToFilm(_ value: FilmItem)

    @objc(removeFilmObject:)
    @NSManaged func removeFromFilm(_ value: FilmItem)

    @objc(addFilm:)
    @NSManaged func addToFilm(_ values: NSSet)

    @objc(removeFilm:)
    @NSManaged func removeFromFilm(_ values: NSSet)
}

extension GenreItem: Identifiable {}
