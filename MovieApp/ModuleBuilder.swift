//
//  ModuleBuilder.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMovieListModule() -> UIViewController
//    func createDetailsModule(selectedMovie: Film?) -> UIViewController
}

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    // MARK: - Public Methods

    func createMovieListModule() -> UIViewController {
        let networkService = NetworkService()
        let filter = FilterTitle()
        let type = filter.filterArray[0].parameter ?? ""
        let viewModel = MovieListViewModel(
            networkService: networkService,
            type: type
        )
        let view = MovieListViewController(viewModel: viewModel)
        view.viewModel = viewModel
        return view
    }

    // MARK: - Public Methods

//    func createDetailsModule(selectedMovie: Film?) -> UIViewController {
//        let view = DetailsViewController()
//        let networkService = NetworkService()
//        let presenter = DetailsPresenter(
//            view: view,
//            networkService: networkService,
//            router: router,
//            selectedMovie: selectedMovie
//        )
//        view.presenter = presenter
//        return view
//    }
}
