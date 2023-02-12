//
//  SettingsViewModelTests.swift
//  AtlasTests
//
//  Created by Franklin Byaruhanga on 12/02/2023.
//

import XCTest
@testable import Atlas

final class SettingsViewModelTests: XCTestCase {
    
    var viewModel: SettingsViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Initialize View Model
        viewModel = SettingsViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: - Tests for Update App Icon
    func testUpdateAppIcon() {
        viewModel.updateAppIcon(to: AppIcon.secondary)
        XCTAssertEqual(viewModel.selectedAppIcon, .secondary)
    }
}
