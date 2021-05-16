//
//  GenreItem+CoreDataClass.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/14/21.
//
//

import CoreData
import Foundation

@objc(GenreItem)
public class GenreItem: NSManagedObject {
    static func make(from genre: Genre, in context: NSManagedObjectContext) -> GenreItem? {
        let genreItem = GenreItem(entity: entity(), insertInto: context)
        genreItem.genres = genre.genre

        return genreItem
    }
}
