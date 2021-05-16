//
//  CoordinatorTest.swift
//  MovieAppTests
//
//  Created by Darya Dainiak on 5/15/21.
//

@testable import MovieApp
import XCTest

///
class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

///
class CoordinatorTest: XCTestCase {
    var coordinator: MainCoordinator!
    var mockNavigationController: MockNavigationController!
    var assemblyBuilder: AssemblyModelBuilder!

    override func setUpWithError() throws {
        mockNavigationController = MockNavigationController()
        coordinator = MainCoordinator(navigationController: mockNavigationController)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        assemblyBuilder = nil
    }

    func testStartCoordinator() {
        coordinator.start()
        XCTAssertTrue(mockNavigationController.presentedVC is MovieListViewController)
    }

    func testGoToDetailsCoordinator() {
        let film = Film(
            posterUrlPreview: "",
            nameRu: "",
            description: "",
            genres: [],
            countries: [],
            year: "",
            rating: "",
            filmId: 1
        )
        coordinator.detailsView(film: film)
        XCTAssertTrue(mockNavigationController.presentedVC is DetailsViewController)
    }
}
