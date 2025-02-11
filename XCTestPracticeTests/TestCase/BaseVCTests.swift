//
//  BaseVCTests.swift
//  XCTestPracticeTests
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import XCTest
@testable import XCTestPractice

// Check Many Views
class AppMemoryLeakTests: BaseViewControllerTestsV2<UIViewController> {
    override var viewControllerTypesToTest: [UIViewController.Type] {
        return [
            SUIKitTest3ViewController.self,
            FUIKitTest4ViewController.self,
            SUIKitTest5ViewController.self,
            SUIKitTest7ViewController.self
        ]
    }
}
// CADisplayLink
class BaseVCTest2Tests: BaseViewControllerTests<FUIKitTest5ViewController> { }

// NotificationCenter
class BaseVCTest4Tests: BaseViewControllerTests<FUIKitTest7ViewController> { }

// Timer
class BaseVCTest5Tests: BaseViewControllerTests<SUIKitTest4ViewController> { }

// Closure Capture
class BaseVCTest6Tests: BaseViewControllerTests<FUIKitTest3ViewController> { }

// URLSession Completion
class BaseVCTest7Tests: BaseViewControllerTests<FUIKitTest8ViewController> { }

// Delegate Retain Cycle
class BaseVCTest8Tests: BaseViewControllerTests<FUIKitTest9ViewController> { }

// DispatchQueue.asyncAfter
class BaseVCTest9Tests: BaseViewControllerTests<FUIKitTest10ViewController> { }

// Combine Subscription Leak
class BaseVCTest11Tests: BaseViewControllerTests<FUIKitTest12ViewController> { }

// ParentChild Retain
class BaseVCTest3Tests: BaseViewControllerTests<FUIKitTest6ViewController> {
    override func createChildViewController() -> UIViewController? {
        return FChildViewController()
    }
}

// Gesture Recognizer
class BaseVCTest10Tests: BaseViewControllerTests<FUIKitTest11ViewController> {
    func testMemoryLeakOnGesture() {
        testViewController_MemoryLeak_Function(functionToTest: #selector(FUIKitTest11ViewController.leakingClosureMethod))
    }
}
