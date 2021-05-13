//
//  CountryItem+CoreDataProperties.swift
//  MovieApp
//
//  Created by Aliaksandr Dainiak on 5/13/21.
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
    @NSManaged var newRelationship: FilmItem?
}

extension CountryItem: Identifiable {}
