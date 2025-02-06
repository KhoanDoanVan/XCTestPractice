//
//  ButtonGestureUITests.swift
//  XCTestPracticeUITests
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import XCTest
import SwiftUI


final class ButtonGestureUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    func testMoveButtonAndChangeColor() {
        let button = app.buttons["Click Me!"]
        
        // Ensure the button exists
        XCTAssertTrue(button.exists, "Button should exist")

        // Move the button by simulating a drag gesture
        let startCoordinate = button.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endCoordinate = startCoordinate.withOffset(CGVector(dx: 100, dy: 100))
        
        // Perform drag gesture from start to end position
        startCoordinate.press(forDuration: 0.1, thenDragTo: endCoordinate)
        
        // After drag, ensure that the button position has changed (you may need to add logic here for position verification)
        
        // Tap the button to change its color
        button.tap()
    }
}
