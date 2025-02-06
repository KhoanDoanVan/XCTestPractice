//
//  LoginViewUITests.swift
//  XCTestPracticeUITests
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import XCTest

final class LoginViewUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false  /// Stops execution if a failure occurs
        app.launch() /// Launch the app before each test
    }
    
    func testSuccessfulLogin() {
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["loginButton"]
        let welcomeMessage = app.staticTexts["welcomeMessage"]
        
        /// Simulate user input
        usernameField.tap()
        usernameField.typeText("testuser")
        
        passwordField.tap()
        passwordField.typeText("password123")
        
        /// Tap login button
        loginButton.tap()
        
        /// Assert: Welcome message appears
        XCTAssertTrue(welcomeMessage.exists, "User should see welcome message after successful login.")
    }
    
    func testFailedLogin() {
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["loginButton"]
        let errorMessage = app.staticTexts["errorMessage"]
        
        /// Simulate wrong input
        usernameField.tap()
        usernameField.typeText("wronguser")
        
        passwordField.tap()
        passwordField.typeText("wrongpassword")
        
        /// Tap login button
        loginButton.tap()
        
        /// Assert: Welcome message appears
        XCTAssertTrue(errorMessage.exists, "User should see an error message after entering invalid credentials.")
    }
}
