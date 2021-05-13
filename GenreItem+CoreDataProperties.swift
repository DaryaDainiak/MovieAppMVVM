//
//  GenreItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/13/21.
//
//

import CoreData
import Foundation

///
public extension GenreItem {
    @nonobjc class func fetchRequest() -> NSFetchRequest<GenreItem> {
        return NSFetchRequest<GenreItem>(entityName: "GenreItem")
    }

    @NSManaged var genre: String?
    @NSManaged var newRelationship: FilmItem?
}

extension GenreItem: Identifiable {}
