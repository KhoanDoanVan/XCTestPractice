//
//  BaseViewControllerTestsV2.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 11/2/25.
//

import XCTest
@testable import XCTestPractice

class BaseViewControllerTestsV2<T: UIViewController>: XCTestCase {
    
    var window: UIWindow!

    /// 🔹 Override this in subclasses to provide the list of view controller types
    var viewControllerTypesToTest: [T.Type] { return [] }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        window.makeKeyAndVisible()
    }

    override func tearDownWithError() throws {
        window = nil
        try super.tearDownWithError()
    }

    // MARK: - ✅ Test Passed View Controllers for Memory Leaks
    func testAllScreensForLeaks() {
        guard !viewControllerTypesToTest.isEmpty else {
            XCTFail("❌ No view controllers provided for testing!")
            return
        }

        for viewControllerType in viewControllerTypesToTest {
            weak var weakViewController: UIViewController?

            autoreleasepool {
                let rootVC = UIViewController() // Empty root VC to present from
                window.rootViewController = rootVC
                rootVC.view.frame = UIScreen.main.bounds
                rootVC.view.backgroundColor = .white
                window.addSubview(rootVC.view) // 🔹 Ensure in hierarchy

                let vc = viewControllerType.init()
                weakViewController = vc

                let expectation = self.expectation(description: "Dismiss VC")

                rootVC.present(vc, animated: false) {
                    vc.dismiss(animated: false) {
                        expectation.fulfill() // Ensure dismissal completes
                    }
                }

                self.wait(for: [expectation], timeout: 1.0) //  Ensure full lifecycle
            }

            XCTAssertNil(weakViewController, "❌ Memory leak detected in \(viewControllerType)!")
        }
    }
}
