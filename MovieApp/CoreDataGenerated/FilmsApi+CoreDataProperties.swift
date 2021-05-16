//
//  FilmsApi+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/13/21.
//
//

import CoreData
import Foundation

///
public extension FilmsApi {
    @nonobjc class func fetchRequest() -> NSFetchRequest<FilmsApi> {
        return NSFetchRequest<FilmsApi>(entityName: "FilmsApi")
    }

    @NSManaged var films: [Int]?
    @NSManaged var pagesCount: Int16
}

extension FilmsApi: Identifiable {}
