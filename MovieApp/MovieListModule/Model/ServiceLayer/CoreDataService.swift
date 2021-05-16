//
//  CoreDataService.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/13/21.
//

import CoreData
import UIKit

///
final class CoreDataService {
    // MARK: - Public Properties

    var managedContext: NSManagedObjectContext?

    // MARK: - Public Methods

    func save(films: [Film]) {
        guard let context = managedContext else { return }

        perform(in: context) {
            films.forEach {
                _ = FilmItem.make(from: $0, in: context)
            }
        }
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

    // MARK: - Private Methods

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
}
