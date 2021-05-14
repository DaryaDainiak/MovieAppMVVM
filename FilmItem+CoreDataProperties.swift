//
//  FilmItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/14/21.
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
    @NSManaged var nameRu: String?
    @NSManaged var posterUrlPreview: String?
    @NSManaged var rating: String?
    @NSManaged var year: String?
}

extension FilmItem: Identifiable {}
