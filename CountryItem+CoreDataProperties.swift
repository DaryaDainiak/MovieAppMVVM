//
//  CountryItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/14/21.
//
//

import CoreData
import Foundation

///
public extension CountryItem {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CountryItem> {
        return NSFetchRequest<CountryItem>(entityName: "CountryItem")
    }

    @NSManaged var country: String?
    @NSManaged var film: NSSet?
}

// MARK: Generated accessors for film

///
public extension CountryItem {
    @objc(addFilmObject:)
    @NSManaged func addToFilm(_ value: FilmItem)

    @objc(removeFilmObject:)
    @NSManaged func removeFromFilm(_ value: FilmItem)

    @objc(addFilm:)
    @NSManaged func addToFilm(_ values: NSSet)

    @objc(removeFilm:)
    @NSManaged func removeFromFilm(_ values: NSSet)
}

extension CountryItem: Identifiable {}
