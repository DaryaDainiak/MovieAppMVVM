//
//  MainCoordinator.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import Foundation
import UIKit

///
class MainCoordinator: Coordinator {
    // MARK: - Private Properties

    private var moduleBuilder: AssemblyModelBuilder?

    // MARK: - Public Properties

    private(set) var childCoordinators: [Coordinator] = []

    private(set) var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        moduleBuilder = AssemblyModelBuilder(coordinator: self)
    }

    // MARK: - Public Methods

    func start() {
        guard let movieVC = moduleBuilder?.createMovieListModule() else { return }
        navigationController.pushViewController(movieVC, animated: false)
    }

    func detailsView(film: Film) {
        guard let detailsVC = moduleBuilder?.createDetailsModule(selectedMovie: film) else { return }
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
