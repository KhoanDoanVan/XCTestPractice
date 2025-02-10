//
//  BaseViewControllerTests.swift
//  XCTestPracticeTests
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import XCTest
@testable import XCTestPractice

class BaseViewControllerTests<T: UIViewController>: XCTestCase {
    
    var viewController: T!
    var childViewController: UIViewController?


    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = T()
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        try super.tearDownWithError()
    }

    /// `viewController` should NOT be nil
    func testViewController_NotNil() {
        XCTAssertNotNil(viewController, "\(T.self) should not be nil")
    }

    /// Ensure view is loaded
    func testViewDidLoad_Called() {
        XCTAssertTrue(viewController.isViewLoaded, "\(T.self)'s view should be loaded")
    }

    // MARK: - Base Check Memory Leak
    /// Proper memory leak check
    func testViewController_MemoryLeak() {
        weak var weakViewController: T?

        autoreleasepool {
            var viewController: T? = T()
            weakViewController = viewController
            viewController?.loadViewIfNeeded() /// Load view to simulate real usage
            viewController = nil /// Remove strong reference
        }

        XCTAssertNil(weakViewController, "\(T.self) is leaking memory!")
    }
    
    // MARK: - ParentChild
    /// **Test if View Controller inside a Parent-Child relationship is deallocated**
    func testViewController_MemoryLeak_ParentChild() {
        weak var weakParentVC: T?
        weak var weakChildVC: UIViewController?

        autoreleasepool {
            let parentVC = T()
            weakParentVC = parentVC

            /// ✅ Check if the subclass has a child view controller
            if let childVC = createChildViewController() {
                weakChildVC = childVC

                parentVC.addChild(childVC)
                parentVC.view.addSubview(childVC.view)
                childVC.didMove(toParent: parentVC)

                /// ✅ Ensure proper cleanup
                childVC.willMove(toParent: nil)
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        }

        XCTAssertNil(weakParentVC, "❌ ParentViewController was not deallocated properly, possible memory leak!")
        XCTAssertNil(weakChildVC, "❌ ChildViewController was not deallocated properly, possible memory leak!")
    }

    /// Override this function in subclasses to provide a child VC if needed
    func createChildViewController() -> UIViewController? {
        return nil /// Default: No child view controller
    }
    
    // MARK: - Gesture
    func testViewController_MemoryLeak_Function(functionToTest: Selector?) {
        weak var weakVC: T?

        autoreleasepool {
            let window = UIWindow()
            let viewController = T()
            weakVC = viewController

            window.rootViewController = viewController
            window.makeKeyAndVisible()

            /// ✅ Simulate button click before dismissing
            if let functionToTest = functionToTest {
                simulateButtonTap(in: viewController, action: functionToTest)
            }

            /// ✅ Dismiss the view controller after 6 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                viewController.dismiss(animated: false)
            }
        }

        /// ❌ If this fails, the view controller is leaking!
        XCTAssertNil(weakVC, "❌ \(T.self) is leaking memory!")
    }
    
    /// ✅ Simulate a button tap programmatically
    private func simulateButtonTap(in viewController: T, action: Selector) {
        let button = UIButton()
        button.addTarget(viewController, action: action, for: .touchUpInside)

        /// Simulate button tap
        button.sendActions(for: .touchUpInside)
    }
}
