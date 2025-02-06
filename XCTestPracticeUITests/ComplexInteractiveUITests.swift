//
//  ComplexInteractiveUITests.swift
//  XCTestPracticeUITests
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import XCTest

final class ComplexInteractiveUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testLoginSuccess() {
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["loginButton"]
        let welcomeMessage = app.staticTexts["welcomeMessage"]

        usernameField.tap()
        usernameField.typeText("test")

        passwordField.tap()
        passwordField.typeText("1234")

        loginButton.tap()

        XCTAssertTrue(welcomeMessage.exists, "User should see a welcome message after logging in.")
    }

    func testCounterIncrementAndDecrement() {
        let increaseButton = app.buttons["increaseButton"]
        let decreaseButton = app.buttons["decreaseButton"]
        let counterLabel = app.staticTexts["counterLabel"]

        increaseButton.tap()
        XCTAssertEqual(counterLabel.label, "1")

        decreaseButton.tap()
        XCTAssertEqual(counterLabel.label, "0")
    }

    
    func testDarkModeTurnOff() {
        let darkModeToggle = app.switches["darkModeToggle"]
        
        // Ensure Toggle exists
        XCTAssertTrue(darkModeToggle.exists, "Dark Mode Toggle should exist")

        // Tap the toggle
        darkModeToggle.tap()
        sleep(1) // Ensure UI updates

        // Check that the value changed
        darkModeToggle.swipeLeft() // Try swipe to toggle OFF
        XCTAssertEqual(darkModeToggle.value as? String, "1", "Toggle should be OFF after swipe")
    }
    
    func testDarkModeTurnOn() {
        let darkModeToggle = app.switches["darkModeToggle"]
        
        // Ensure Toggle exists
        XCTAssertTrue(darkModeToggle.exists, "Dark Mode Toggle should exist")

        // Tap the toggle
        darkModeToggle.tap()
        sleep(1) // Ensure UI updates

        // Check that the value changed
        darkModeToggle.swipeRight() // Try swipe to toggle ON
        XCTAssertEqual(darkModeToggle.value as? String, "0", "Toggle should be ON after swipe")
    }

    func testSliderBrightness() {
        let brightnessSlider = app.sliders["brightnessSlider"]
        brightnessSlider.adjust(toNormalizedSliderPosition: 0.8)
    }

    func testAgeStepperIncrements() {
        let ageStepper = app.steppers["ageStepper"]
        XCTAssertTrue(ageStepper.exists, "Age Stepper should exist")

        // Use the correct identifiers from the debug output
        let incrementButton = ageStepper.buttons["add"]

        XCTAssertTrue(incrementButton.exists, "Increment button should exist")

        // Get current value before tapping
        let initialValue = app.staticTexts.firstMatch.label
        print("Initial Age: \(initialValue)")

        // Tap the increment button (right side)
        incrementButton.tap()

        // Wait for the value to change
        let incrementedValue = app.staticTexts.firstMatch
        let existsAfterIncrement = incrementedValue.waitForExistence(timeout: 2)
        XCTAssertTrue(existsAfterIncrement, "Age should change after increment")

        print("After Increment: \(incrementedValue.label)")
        XCTAssertNotEqual(initialValue, ageStepper.value as? String, "Age should increase after increment")

    }
    
    func testAgeStepperDecrements() {
        let ageStepper = app.steppers["ageStepper"]
        XCTAssertTrue(ageStepper.exists, "Age Stepper should exist")

        // Use the correct identifiers from the debug output
        let decrementButton = ageStepper.buttons["remove"]

        XCTAssertTrue(decrementButton.exists, "Decrement button should exist")

        // Get current value before tapping
        let initialValue = app.staticTexts.firstMatch.label
        print("Initial Age: \(initialValue)")
        
        // Tap the decrement button (left side)
        decrementButton.tap()

        // Wait for the value to change
        let decrementedValue = app.staticTexts.firstMatch
        let existsAfterDecrement = decrementedValue.waitForExistence(timeout: 2)
        XCTAssertTrue(existsAfterDecrement, "Age should change after decrement")

        
        print("After Decrement: \(decrementedValue.label)")
        XCTAssertEqual(initialValue, decrementedValue.label, "Age should return to the original value after decrement")
    }

    func testShowAlert() {
        let alertButton = app.buttons["alertButton"]
        alertButton.tap()
        
        let alert = app.alerts["Hello!"]
        XCTAssertTrue(alert.exists, "Alert should appear.")
        
        alert.buttons["OK"].tap()
    }

    func testShowModal() {
        let modalButton = app.buttons["modalButton"]
        modalButton.tap()
        
        let modalText = app.staticTexts["modalText"]
        XCTAssertTrue(modalText.exists, "Modal should be displayed.")
    }
}
