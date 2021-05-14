//
//  CountryItem+CoreDataClass.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/14/21.
//
//

import CoreData
import Foundation

@objc(CountryItem)
public class CountryItem: NSManagedObject {
    static func make(from country: Country, in context: NSManagedObjectContext) -> CountryItem? {
        let countryItem = CountryItem(entity: entity(), insertInto: context)
        countryItem.country = country.country

        return countryItem
    }
}
