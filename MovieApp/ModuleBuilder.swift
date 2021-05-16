//
//  ModuleBuilder.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMovieListModule() -> MovieListViewController
    func createDetailsModule(selectedMovie: Film) -> DetailsViewController
}

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Properties

    let coordinator: MainCoordinator

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func createMovieListModule() -> MovieListViewController {
        let networkService = NetworkService()
        let filter = FilterTitle()
        let type = filter.filterArray[0].parameter ?? ""
        let viewModel = MovieListViewModel(
            networkService: networkService,
            type: type
        )
        viewModel.goToDetails = { [weak self] film in
            self?.coordinator.detailsView(film: film)
        }
        let view = MovieListViewController(viewModel: viewModel)
        view.viewModel = viewModel
        return view
    }

    func createDetailsModule(selectedMovie: Film) -> DetailsViewController {
        let networkService = NetworkService()
        let viewModel = DetailsViewModel(
            networkService: networkService,
            selectedMovie: selectedMovie
        )

        let view = DetailsViewController(viewModel: viewModel)

        view.viewModel = viewModel
        return view
    }
}
