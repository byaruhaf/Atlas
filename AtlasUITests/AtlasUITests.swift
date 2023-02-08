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
//        app.uninstall(name: "Atlas Weather")
    }

    func testTheme() throws {
        // Use this before the alerts appear. I am doing it before app.launch()
        
        let allowButtonPredicate = NSPredicate(format: "label == 'Allow While Using App' || label == 'Allow'")
        // 1st alert
        _ = addUIInterruptionMonitor(withDescription: "Allow to access your location?") { alert -> Bool in
            let alwaysAllowButton = alert.buttons.matching(allowButtonPredicate).element.firstMatch
            if alwaysAllowButton.exists {
                alwaysAllowButton.tap()
                return true
            }
            return false
        }
        // Copy paste if there are more than one alerts to handle in the app
        app.launch()
        app.tabBars["Tab Bar"].buttons["Settings"].tap()
        app.collectionViews.buttons["Image Themes, 🌴 Forest"].tap()
    }
    
    func testAddFavorites() throws {
        // Use this before the alerts appear. I am doing it before app.launch()
        
        let allowButtonPredicate = NSPredicate(format: "label == 'Allow While Using App' || label == 'Allow'")
        // 1st alert
        _ = addUIInterruptionMonitor(withDescription: "Allow to access your location?") { alert -> Bool in
            let alwaysAllowButton = alert.buttons.matching(allowButtonPredicate).element.firstMatch
            if alwaysAllowButton.exists {
                alwaysAllowButton.tap()
                return true
            }
            return false
        }
        // Copy paste if there are more than one alerts to handle in the app
        app.launch()
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
