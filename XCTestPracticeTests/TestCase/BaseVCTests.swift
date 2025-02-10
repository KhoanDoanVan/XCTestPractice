//
//  BaseVCTests.swift
//  XCTestPracticeTests
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import XCTest
@testable import XCTestPractice

// CADisplayLink
class BaseVCTest2Tests: BaseViewControllerTests<UIKitTest5ViewController> { }

// NotificationCenter
class BaseVCTest4Tests: BaseViewControllerTests<UIKitTest7ViewController> { }

// Timer
class BaseVCTest5Tests: BaseViewControllerTests<UIKitTest4ViewController> { }

// Closure Capture
class BaseVCTest6Tests: BaseViewControllerTests<UIKitTest3ViewController> { }

// URLSession Completion
class BaseVCTest7Tests: BaseViewControllerTests<UIKitTest8ViewController> { }

// Delegate Retain Cycle
class BaseVCTest8Tests: BaseViewControllerTests<UIKitTest9ViewController> { }

// DispatchQueue.asyncAfter
class BaseVCTest9Tests: BaseViewControllerTests<UIKitTest10ViewController> { }

// Combine Subscription Leak
class BaseVCTest11Tests: BaseViewControllerTests<UIKitTest12ViewController> { }

// ParentChild Retain
class BaseVCTest3Tests: BaseViewControllerTests<UIKitTest6ViewController> {
    override func createChildViewController() -> UIViewController? {
        return ChildViewController()
    }
}

// Gesture Recognizer
class BaseVCTest10Tests: BaseViewControllerTests<UIKitTest11ViewController> {
    func testMemoryLeakOnGesture() {
        testViewController_MemoryLeak_Function(functionToTest: #selector(UIKitTest11ViewController.leakingClosureMethod))
    }
}
