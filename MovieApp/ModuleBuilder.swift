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
    let movieListUseCase: MovieListUseCaseProtocol

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene

        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let managedContext = sceneDelegate?.coreDataStack.persistentContainer.viewContext
        let coreDataService = CoreDataService(managedContext: managedContext)

        let networkService = NetworkService()

        movieListUseCase = MovieListUseCase(
            networkService: networkService,
            coreDataService: coreDataService
        )
    }

    // MARK: - Public Methods

    func createMovieListModule() -> MovieListViewController {
        let filter = FilterTitle()
        let type = filter.filterArray[0].parameter ?? ""

        let viewModel = MovieListViewModel(
            movieListUseCase: movieListUseCase,
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
        let viewModel = DetailsViewModel(
            movieListUseCase: movieListUseCase,
            selectedMovie: selectedMovie
        )

        let view = DetailsViewController(viewModel: viewModel)

        view.viewModel = viewModel
        return view
    }
}
