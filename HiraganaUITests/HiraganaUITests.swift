//
//  HiraganaUITests.swift
//  HiraganaUITests
//
//  Created by Aidan Cornelius-Bell on 29/8/2025.
//

import XCTest

final class HiraganaUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor
    func testMainGameFlowIsVisible() throws {
        // Check that main UI elements are present
        XCTAssertTrue(app.navigationBars["Hiragana"].exists)
        
        // Check for settings button
        let settingsButton = app.navigationBars["Hiragana"].buttons["gearshape.fill"]
        XCTAssertTrue(settingsButton.exists)
        
        // Check for input field
        let textField = app.textFields["Enter romaji"]
        XCTAssertTrue(textField.waitForExistence(timeout: 2))
        
        // Check for check button
        let checkButton = app.buttons["Check"]
        XCTAssertTrue(checkButton.exists)
    }
    
    @MainActor
    func testTypingAnswerEnablesCheckButton() throws {
        let textField = app.textFields["Enter romaji"]
        XCTAssertTrue(textField.waitForExistence(timeout: 2))
        
        let checkButton = app.buttons["Check"]
        
        // Initially disabled (no text)
        XCTAssertFalse(checkButton.isEnabled)
        
        // Type something
        textField.tap()
        textField.typeText("a")
        
        // Should now be enabled
        XCTAssertTrue(checkButton.isEnabled)
    }
    
    @MainActor
    func testSettingsSheetOpensAndCloses() throws {
        // Open settings
        let settingsButton = app.navigationBars["Hiragana"].buttons["gearshape.fill"]
        XCTAssertTrue(settingsButton.exists)
        settingsButton.tap()
        
        // Check settings sheet is shown
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2))
        
        // Check for Done button
        let doneButton = app.navigationBars["Settings"].buttons["Done"]
        XCTAssertTrue(doneButton.exists)
        
        // Close settings
        doneButton.tap()
        
        // Should be back to main screen
        XCTAssertTrue(app.navigationBars["Hiragana"].waitForExistence(timeout: 2))
    }
    
    @MainActor
    func testSettingsTogglesExist() throws {
        // Open settings
        app.navigationBars["Hiragana"].buttons["gearshape.fill"].tap()
        
        // Wait for settings to appear
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2))
        
        // Check for difficulty toggles
        XCTAssertTrue(app.switches.element(matching: .switch, identifier: nil).firstMatch.exists)
        
        // Check for reset button
        XCTAssertTrue(app.buttons["Reset to defaults"].exists)
        
        // Close settings
        app.navigationBars["Settings"].buttons["Done"].tap()
    }
    
    @MainActor
    func testSkipAndHintButtonsVisible() throws {
        // Check if hint buttons are visible (default is true)
        let skipButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'Skip'")).firstMatch
        let showButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'Show'")).firstMatch
        
        XCTAssertTrue(skipButton.waitForExistence(timeout: 2))
        XCTAssertTrue(showButton.exists)
    }
    
    @MainActor
    func testHintButtonToggles() throws {
        let showButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'Show'")).firstMatch
        let hideButton = app.buttons.containing(NSPredicate(format: "label CONTAINS 'Hide'")).firstMatch
        
        if showButton.waitForExistence(timeout: 2) {
            // Tap show button
            showButton.tap()
            
            // Should now show hide button
            XCTAssertTrue(hideButton.waitForExistence(timeout: 1))
            
            // Tap hide button
            hideButton.tap()
            
            // Should show show button again
            XCTAssertTrue(showButton.waitForExistence(timeout: 1))
        }
    }
    
    @MainActor
    func testStreakCounterIsVisible() throws {
        // Look for flame icon and streak counter
        let streakLabel = app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'flame.fill'")).firstMatch
        XCTAssertTrue(streakLabel.exists || app.images["flame.fill"].exists)
    }
    
    @MainActor
    func testSubmittingAnswerViaKeyboard() throws {
        let textField = app.textFields["Enter romaji"]
        XCTAssertTrue(textField.waitForExistence(timeout: 2))
        
        // Type an answer
        textField.tap()
        textField.typeText("a")
        
        // Submit via keyboard
        app.keyboards.buttons["return"].tap()
        
        // Should see either checkmark or xmark
        let checkmark = app.images["checkmark.circle.fill"]
        let xmark = app.images["xmark.circle.fill"]
        
        // One of these should appear
        let eitherAppears = checkmark.waitForExistence(timeout: 2) || xmark.waitForExistence(timeout: 2)
        XCTAssertTrue(eitherAppears)
    }
    
    @MainActor
    func testResetToDefaultsInSettings() throws {
        // Open settings
        app.navigationBars["Hiragana"].buttons["gearshape.fill"].tap()
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2))
        
        // Find and tap reset button
        let resetButton = app.buttons["Reset to defaults"]
        XCTAssertTrue(resetButton.exists)
        resetButton.tap()
        
        // Close settings
        app.navigationBars["Settings"].buttons["Done"].tap()
        
        // Should be back at main screen
        XCTAssertTrue(app.navigationBars["Hiragana"].waitForExistence(timeout: 2))
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}