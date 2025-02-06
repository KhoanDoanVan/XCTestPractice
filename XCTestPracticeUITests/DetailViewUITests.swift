//
//  DetailViewUITests.swift
//  XCTestPracticeUITests
//
//  Created by Đoàn Văn Khoan on 6/2/25.
//

import XCTest
@testable import XCTestPractice // Replace with the actual module name of your app

final class LeakyViewTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testMemoryLeakInLeakyView() {
        // Create an instance of the view model and a weak reference to it
        var viewModel: LeakyViewModel? = LeakyViewModel()
        weak var weakViewModel = viewModel
        
        // Simulate the navigation to LeakyView
        app.buttons["Show Leaky View"].tap()
        
        // Simulate the increment action to interact with the view
        app.buttons["Increment"].tap()
        
        // Dismiss the sheet (LeakyView)
        app.buttons["Close"].tap() // Assume you have a "Close" button to dismiss the view
        
        // Release the view model and check if it's deallocated
        viewModel = nil
        
        // Check if the view model was deallocated, which means no memory leak
        XCTAssertNil(weakViewModel, "⚠️ LeakyViewModel is not deallocated, memory leak detected!")
    }
}
