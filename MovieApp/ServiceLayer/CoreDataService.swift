//
//  CoreDataService.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/13/21.
//

import CoreData
import UIKit

///
class CoreDataService {
    private init() {}

    static let shared = CoreDataService()
    var managedContext: NSManagedObjectContext?

    func save(films: [Film]) {
        guard let context = managedContext else { return }

        perform(in: context) {
            films.forEach {
                _ = FilmItem.make(from: $0, in: context)
            }
        }

//        for film in films {
//            guard let entity = NSEntityDescription.entity(
//                forEntityName: "FilmItem",
//                in: context
//            ) else { return }
//
//            guard let filmItem = NSManagedObject(entity: entity, insertInto: context) as? FilmItem else { return }
//
//        }
    }

    func getFilmItems() -> [FilmItem] {
        let entity = NSFetchRequest<FilmItem>(entityName: "FilmItem")
        var filmItems: [FilmItem] = []
        do {
            guard let request = entity as? NSFetchRequest<NSFetchRequestResult> else { return [] }
            filmItems = try managedContext?.fetch(request) as? [FilmItem] ?? []

        } catch let error as NSError {
            print("\(error)")
        }

        return filmItems
    }

    private func perform(in context: NSManagedObjectContext, clousure: @escaping () -> ()) {
        context.perform {
            clousure()

            do {
                if context.hasChanges {
                    try context.save()
                    print("Context changes saved")
                } else {
                    print("Context has no changes")
                }
            } catch {
                print(error)
            }
        }
    }

//    static func findOrInsertFilm(in context: NSManagedObjectContext) -> Film? {
//        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
//            print("Model is not available in context!")
//            assert(false)
//            return nil
//        }
//        var film: Film?
//        guard let fetchRequest = Film
//    }
}
