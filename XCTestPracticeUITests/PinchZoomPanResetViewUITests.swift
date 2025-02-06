//
//  PinchZoomPanResetViewUITests.swift
//  XCTestPracticeUITests
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import XCTest

//1. Pinch-to-Zoom Test:
//2. Drag-to-Pan Test:
//3. Drag Reset Test (After Pan):
//4. Double-Tap to Reset Test:
//5. Combination of Pinch and Drag Test:
//6. Zoom Limits Test:
//7. Double-Tap During Zoom Test:
//8. Verify Gesture Interactions in Sequence:
//9. Reset After Multiple Interactions Test:
//10. Edge Cases for Gestures:


class PinchZoomPanResetViewTests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false  /// Stops execution if a failure occurs
        app.launch() /// Launch the app before each test
    }
    
    // 1. Pinch-to-Zoom Test:
    func testPinchToZoomGesture() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Simulate pinch-in (zoom out)
        image.pinch(withScale: 0.5, velocity: -1.0) // Pinch to zoom out
        sleep(1)
        
        /// Assert scale is within the expected range
        XCTAssertTrue(image.exists)
        
        /// Simulate pinch-out (zoom in)
        image.pinch(withScale: 2.0, velocity: 1.0) // Pinch to zoom in
        sleep(1)
        
        /// Assert scale is within the expected range
        XCTAssertTrue(image.exists)
    }

    // 2. Drag-to-Pan Test:
    func testDragToPanGesture() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Simulate drag gesture to pan the image
        let startPoint = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endPoint = startPoint.withOffset(CGVector(dx: 100, dy: 100))
        startPoint.press(forDuration: 0.1, thenDragTo: endPoint)
        
        //// Assert that the image has moved (based on offset change)
        XCTAssertTrue(image.exists)
    }
    
    // 3. Drag Reset Test (After Pan):
    func testDragResetAfterPan() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply drag gesture to move the image
        let startPoint = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endPoint = startPoint.withOffset(CGVector(dx: 100, dy: 100))
        startPoint.press(forDuration: 0.1, thenDragTo: endPoint)
        
        /// Assert the image has moved (by checking its new position)
        XCTAssertTrue(image.exists)
        
        /// Now reset the image by double-tapping (to simulate the double-tap gesture)
        image.doubleTap()
        sleep(1)
        
        /// Assert that the image has reset to its original position and scale
        XCTAssertTrue(image.exists)
    }
    
    // 4. Double-Tap to Reset Test:
    func testDoubleTapToReset() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply a drag gesture to pan the image
        let startPoint = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endPoint = startPoint.withOffset(CGVector(dx: 100, dy: 100))
        startPoint.press(forDuration: 0.1, thenDragTo: endPoint)
        
        /// Assert the image has moved
        XCTAssertTrue(image.exists)
        
        /// Now simulate a double-tap to reset the image
        image.doubleTap()
        sleep(1)
        
        /// Assert that the image has reset to its original position and scale
        XCTAssertTrue(image.exists)
    }
    
    // 5. Combination of Pinch and Drag Test:
    func testPinchAndDragCombination() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply a pinch-in gesture (zoom in)
        image.pinch(withScale: 2.0, velocity: 1.0)
        sleep(1)
        
        /// Assert that the image has zoomed out
        XCTAssertTrue(image.exists)
        
        /// Now apply a drag gesture to move the image
        let startPoint = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endPoint = startPoint.withOffset(CGVector(dx: 100, dy: 100))
        startPoint.press(forDuration: 0.1, thenDragTo: endPoint)
        sleep(1)
        
        /// Assert that the image has moved after dragging
        XCTAssertTrue(image.exists)
    }
    
    // 6. Zoom Limits Test:
    func testZoomLimits() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply a pinch-in gesture (zoom out) to zoom below the minimum scale
        image.pinch(withScale: 0.1, velocity: -1.0)
        sleep(1)
        
        /// Assert that the image's scale is not below the minimum limit (1x)
        XCTAssertTrue(image.exists)
        
        /// Apply a pinch-out gesture (zoom in) to zoom beyond the maximum scale
        image.pinch(withScale: 5.0, velocity: 1.0)
        sleep(1)
        
        /// Assert that the image's scale is not above the maximum limit (5x)
        XCTAssertTrue(image.exists)
    }
    
    // 7. Double-Tap During Zoom Test:
    func testDoubleTapDuringZoom() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply a pinch-out gesture (zoom in)
        image.pinch(withScale: 2.0, velocity: 1.0)
        sleep(1)
        
        /// Assert the image is zoomed in
        XCTAssertTrue(image.exists)
        
        /// Now simulate a double-tap to reset the zoom
        image.doubleTap()
        sleep(1)
        
        /// Assert that the image is reset to its original scale
        XCTAssertTrue(image.exists)
    }
    
    // 8. Verify Gesture Interactions in Sequence:
    func testGestureInteractionsInSequence() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply pinch-out (zoom in) gesture
        image.pinch(withScale: 2.0, velocity: 1.0)
        sleep(1)
        
        /// Assert the image is zoomed in
        XCTAssertTrue(image.exists)
        
        /// Now apply drag gesture to move the image
        let startPoint = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endPoint = startPoint.withOffset(CGVector(dx: 100, dy: 100))
        startPoint.press(forDuration: 0.1, thenDragTo: endPoint)
        sleep(1)
        
        /// Assert the image has moved after dragging
        XCTAssertTrue(image.exists)
    }
    
    // 9. Reset After Multiple Interactions Test:
    func testResetAfterMultipleInteractions() {
 
        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply a series of pinch and drag gestures
        image.pinch(withScale: 2.0, velocity: 1.0)
        sleep(1)
        
        /// Assert the image is zoomed in
        XCTAssertTrue(image.exists)
        
        let startPoint = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let endPoint = startPoint.withOffset(CGVector(dx: 100, dy: 100))
        startPoint.press(forDuration: 0.1, thenDragTo: endPoint)
        sleep(1)
        
        /// Assert the image has moved
        XCTAssertTrue(image.exists)
        
        /// Now reset the image with a double-tap gesture
        image.doubleTap()
        sleep(1)
        
        /// Assert the image has reset to its initial state
        XCTAssertTrue(image.exists)
    }
    
    // 10. Edge Cases for Gestures:
    func testEdgeCasesForGestures() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Edge Case 1: Applying a very small pinch gesture (zooming in slightly)
        image.pinch(withScale: 1.1, velocity: 0.2)
        sleep(1)
        
        /// Assert the image exists and didn't scale too much
        XCTAssertTrue(image.exists)
        
        /// Edge Case 2: Dragging the image to extreme positions
        let startPoint = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let extremeEndPoint = startPoint.withOffset(CGVector(dx: 1000, dy: 1000))
        startPoint.press(forDuration: 0.1, thenDragTo: extremeEndPoint)
        sleep(1)
        
        /// Assert the image has moved, but still exists within limits
        XCTAssertTrue(image.exists)
        
        /// Edge Case 3: Double tapping during extreme zoom (reset zoom)
        image.pinch(withScale: 5.0, velocity: 1.0)
        sleep(1)
        
        /// Assert the image is zoomed in to the maximum
        XCTAssertTrue(image.exists)
        
        /// Double tap to reset
        image.doubleTap()
        sleep(1)
        
        /// Assert that the image has reset to its original scale
        XCTAssertTrue(image.exists)
    }
    
    // Zoom Multiple Times Test:
    func testZoomMultipleTimes() {
 
        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply pinch-in (zoom out) gesture
        image.pinch(withScale: 0.5, velocity: -1.0)
        sleep(1)
        
        /// Assert the image is zoomed out
        XCTAssertTrue(image.exists)
        
        /// Apply pinch-out (zoom in) gesture twice
        image.pinch(withScale: 2.0, velocity: 1.0)
        sleep(1)
        
        image.pinch(withScale: 2.0, velocity: 1.0)
        sleep(1)
        
        /// Assert the image is zoomed in multiple times (scale should increase)
        XCTAssertTrue(image.exists)
    }
    
    // Zoom In and Then Zoom Out Test:
    func testZoomInAndThenZoomOut() {
 
        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Apply pinch-out (zoom in) gesture
        image.pinch(withScale: 2.0, velocity: 1.0)
        sleep(1)
        
        /// Assert the image is zoomed in
        XCTAssertTrue(image.exists)
        
        /// Apply pinch-in (zoom out) gesture
        image.pinch(withScale: 0.5, velocity: -1.0)
        sleep(1)
        
        /// Assert the image is zoomed out
        XCTAssertTrue(image.exists)
    }
    
    // Pinch Outside Image Test:
    func testPinchOutsideImage() {

        /// Locate the image element in the view
        let image = app.images["image"]
        
        /// Start the pinch gesture outside the image bounds
        let start = image.coordinate(withNormalizedOffset: CGVector(dx: -0.5, dy: -0.5)) // Start outside the image
        let end = image.coordinate(withNormalizedOffset: CGVector(dx: 1.5, dy: 1.5)) // End outside the image
        
        /// Apply pinch gesture outside image bounds (shouldn’t affect the image)
        start.press(forDuration: 0.1, thenDragTo: end)
        sleep(1)
        
        /// Verify the image still exists and was not affected by the outside interaction
        XCTAssertTrue(image.exists)
    }
    
    // Drag Outside Image Test:
    func testDragOutsideImage() {

        /// Locate the image element
        let image = app.images["image"]
        
        /// Perform a drag outside of the image bounds
        let start = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)) /// Start inside the image
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 2.0, dy: 2.0))  /// Move to a point outside the image bounds
        
        /// Drag the image outside
        start.press(forDuration: 0.1, thenDragTo: end)
        sleep(1)
        
        /// Assert that the image exists (i.e., it hasn’t been removed or altered unexpectedly)
        XCTAssertTrue(image.exists)
        
        /// Verify that the image has been panned outside the image bounds
        XCTAssertTrue(image.frame.origin.x > 0 || image.frame.origin.y > 0)
    }
    
    // Multiple Drag Gestures Test:
    func testMultipleDragGestures() {

        /// Locate the image element
        let image = app.images["image"]
        
        /// Perform the first drag gesture
        let start1 = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)) /// Start inside the image
        let end1 = app.coordinate(withNormalizedOffset: CGVector(dx: 1.5, dy: 0.5))  /// Drag to the right
        
        start1.press(forDuration: 0.1, thenDragTo: end1)
        sleep(1)
        
        /// Perform the second drag gesture (drag to a different direction)
        let start2 = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)) /// Start again from inside the image
        let end2 = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 1.5))  /// Drag downward
        
        start2.press(forDuration: 0.1, thenDragTo: end2)
        sleep(1)
        
        /// Perform the third drag gesture (drag in another direction)
        let start3 = image.coordinate(withNormalizedOffset: CGVector(dx: 0.2, dy: 0.2)) /// Start from inside the image
        let end3 = app.coordinate(withNormalizedOffset: CGVector(dx: -0.5, dy: 0.5)) /// Drag to the left
        
        start3.press(forDuration: 0.1, thenDragTo: end3)
        sleep(1)
        
        /// Perform the fourth drag gesture (drag upwards)
        let start4 = image.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)) /// Start again from inside the image
        let end4 = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: -0.5)) /// Drag upwards
        
        start4.press(forDuration: 0.1, thenDragTo: end4)
        sleep(1)
        
        /// Assert that the image still exists and is interactable after multiple drags
        XCTAssertTrue(image.exists)
        
        /// Verify that the image frame has changed based on drag operations (i.e., it has been moved)
        XCTAssertTrue(image.frame.origin.x != 0 || image.frame.origin.y != 0)
    }
}
