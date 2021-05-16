//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by Darya Dainiak on 5/16/21.
//

@testable import MovieApp
import XCTest

///
class MovieAppUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(10)
        XCTAssertTrue(app.navigationBars["Movies"].exists)
        XCTAssertTrue(app.isOnMainView)
        app.cells.allElementsBoundByIndex.first?.tap()
    }
}

extension XCUIApplication {
    var isOnMainView: Bool {
        return otherElements["mainView"].exists
    }
}
