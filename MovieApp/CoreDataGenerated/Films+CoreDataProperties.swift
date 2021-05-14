//
//  Films+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/13/21.
//
//

import CoreData
import Foundation

///
public extension Films {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Films> {
        return NSFetchRequest<Films>(entityName: "Films")
    }

    @NSManaged var countries: [Int]?
    @NSManaged var filmId: Int64
    @NSManaged var genres: [Int]?
    @NSManaged var nameRu: String?
    @NSManaged var posterUrlPreview: Data?
    @NSManaged var rating: String?
    @NSManaged var year: String?
}

extension Films: Identifiable {}
