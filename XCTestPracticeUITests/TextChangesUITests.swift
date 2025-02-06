//
//  TextChangesUITests.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 6/2/25.
//

import XCTest

class MyUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testButtonResponseTime() {
        let button = app.buttons["Change Text"]
        
        // Measure the time it takes to change the label's text
        self.measure {
            button.tap()  // Simulate the button tap
            let updatedLabel = app.staticTexts["Text Changed!"]
            
            // Assert that the label text changes as expected
            XCTAssertTrue(updatedLabel.exists)
        }
    }
    
    func testMultipleButtonTaps() {
        let button = app.buttons["Change Text"]
        let initialLabel = app.staticTexts["Hello, World!"]
        let updatedLabel = app.staticTexts["Text Changed!"]

        // Ensure the initial state is correct
        XCTAssertTrue(initialLabel.exists)

        // Measure the response time for multiple taps
        for i in 1...5 {
            self.measure {
                button.tap()  // Simulate the button tap
                XCTAssertTrue(updatedLabel.exists, "Label did not update after tap \(i)")
            }
        }
    }
    
    func testButtonActionCompletesInTime() {
            let button = app.buttons["Change Text"]
            let updatedLabel = app.staticTexts["Text Changed!"]

            // Start the action and measure time taken for label to update
            let expectation = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: updatedLabel, handler: nil)
            
            // Tap the button
            button.tap()

            // Wait until the label appears or timeout (max 2 seconds)
            let result = XCTWaiter.wait(for: [expectation], timeout: 1.2)

            // Assert that the label updated within the expected time
            switch result {
            case .completed:
                XCTAssertTrue(updatedLabel.exists, "Label did not update within 2 seconds")
            case .timedOut:
                XCTFail("Action did not complete within 2 seconds")
            default:
                break
            }
        }
}
