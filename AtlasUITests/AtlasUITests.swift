//
//  AtlasUITests.swift
//  AtlasUITests
//
//  Created by Franklin Byaruhanga on 07/02/2023.
//

import XCTest

final class AtlasUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.uninstall(name: "Atlas Weather")
    }

    func testTheme() throws {
        app.launch()
        app.tabBars["Tab Bar"].buttons["Settings"].tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Image Themes, 🌴 Forest"]/*[[".cells.buttons[\"Image Themes, 🌴 Forest\"]",".buttons[\"Image Themes, 🌴 Forest\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testAddFavorites() throws {
        app.launch()
//        app.alerts["Allow “Atlas Weather” to use your location?"].scrollViews.otherElements.buttons["Allow While Using App"].tap()
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.navigationBars["Atlas.FavoriteCitiesView"].buttons["Add"].tap()
        let search = app.navigationBars["Add City"].searchFields["Enter your city name"]
        search.tap()
        search.typeText("Los Angeles, CA")
        let results = app.tables.cells.containing(.staticText, identifier: "Los Angeles, CA").element
        results.tap()
    }
}
