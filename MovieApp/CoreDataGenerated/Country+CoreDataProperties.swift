//
//  Country+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/13/21.
//
//

import CoreData
import Foundation

///
public extension Country {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged var country: String?
}

extension Country: Identifiable {}
