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
    private var moduleBuilder = AssemblyModelBuilder()

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let movieVC = moduleBuilder.createMovieListModule()
        movieVC.coordinator = self
        navigationController.pushViewController(movieVC, animated: false)
    }

    func detailsView(film: Film) {
        let detailsVC = moduleBuilder.createDetailsModule(selectedMovie: film)
        detailsVC.coordinator = self
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
