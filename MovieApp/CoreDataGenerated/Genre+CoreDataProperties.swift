//
//  Genre+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/13/21.
//
//

import CoreData
import Foundation

///
public extension Genre {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged var genre: String?
}

extension Genre: Identifiable {}
