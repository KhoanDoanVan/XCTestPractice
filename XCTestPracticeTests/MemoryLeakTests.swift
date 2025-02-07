//
//  MemoryLeakTests.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import XCTest
@testable import XCTestPractice

class MemoryLeakTests: XCTestCase {

    func testViewModelMemoryLeak() {
        weak var weakViewModel: MyViewModel?

        autoreleasepool {
            let viewModel = MyViewModel()
            weakViewModel = viewModel
            XCTAssertNotNil(weakViewModel, "ViewModel should exist inside autorelease pool")
        }

        XCTAssertNil(weakViewModel, "❌ Memory leak detected: ViewModel was not deallocated!")
    }
    
    func testViewModelMemoryLeak2() {
        weak var weakViewModel: MyViewModel?

        autoreleasepool {
            let viewModel = MyViewModel()
            weakViewModel = viewModel
            XCTAssertNotNil(weakViewModel, "ViewModel should exist inside autorelease pool")
        }

        XCTAssertNil(weakViewModel, "❌ Memory leak detected: ViewModel was not deallocated!")
    }
    
    // MARK: - UIKit 1
    func test_MyViewController_Leaks_100Times() {
        for _ in 0..<100 { // Run test 100 times for stability
            checkViewControllerLeak()
        }
    }
    
    private func checkViewControllerLeak() {
        autoreleasepool {
            var viewController: UIKitTest1ViewController? = UIKitTest1ViewController()
            weak var weakViewController = viewController

            DispatchQueue.main.async {
                viewController?.dismiss(animated: false)
                viewController = nil
            }

            // Allow extra time for deallocation
            RunLoop.current.run(until: Date() + 2.0)

            XCTAssertNil(weakViewController, "❌ Memory Leak Detected!")
        }
    }
    
    // MARK: - UIKit 2
    func test_MyViewController_Leaks_100Times2() {
        for _ in 0..<100 { // Run test 100 times for stability
            checkViewControllerLeak2()
        }
    }
    
    private func checkViewControllerLeak2() {
        autoreleasepool {
            var viewController: UIKitTest2ViewController? = UIKitTest2ViewController()
            weak var weakViewController = viewController
            
            DispatchQueue.main.async {
                viewController?.dismiss(animated: false)
                viewController = nil
            }

            // Allow extra time for deallocation
            RunLoop.current.run(until: Date() + 2.0)

            XCTAssertNil(viewController, "❌ Memory Leak Detected!")
        }
    }
    
    // MARK: - UIKit 3
    func test_MyViewController_Leaks_1Time3() {
        checkViewControllerLeak3()
    }
    
    private func checkViewControllerLeak3() {
        weak var weakVC: UIKitTest3ViewController?

        autoreleasepool {
            let vc = UIKitTest3ViewController()
            weakVC = vc
            // Simulate lifecycle events
            vc.loadViewIfNeeded()
        }

        // The object should be nil if it was deallocated correctly
        XCTAssertNil(weakVC, "LeakingViewController was not deallocated properly, possible memory leak detected!")
    }
    
    // MARK: - UIKit 4
    func test_MyViewController_Leaks_1Time4() {
        checkViewControllerLeak4()
    }

    private func checkViewControllerLeak4() {
        weak var weakVC: UIKitTest4ViewController?

        autoreleasepool {
            let vc = UIKitTest4ViewController()
            weakVC = vc
            vc.loadViewIfNeeded()
        }

        XCTAssertNil(weakVC, "TimerFixedViewController was not deallocated properly, possible memory leak detected!")
    }
    
    // MARK: - UIKit 5
    func test_MyViewController_Leaks_1Time5() {
        checkViewControllerLeak5()
    }

    private func checkViewControllerLeak5() {
        weak var weakVC: UIKitTest5ViewController?

        autoreleasepool {
            let vc = UIKitTest5ViewController()
            weakVC = vc
            vc.loadViewIfNeeded()
        }

        XCTAssertNil(weakVC, "CADisplayLinkFixedViewController was not deallocated properly, possible memory leak detected!")
    }
    
    // MARK: - UIKit 6
    func test_MyViewController_Leaks_1Time6() {
        checkParentViewControllerLeak6()
    }

    private func checkParentViewControllerLeak6() {
        weak var weakParentVC: UIKitTest6ViewController?
        weak var weakChildVC: ChildViewController?

        autoreleasepool {
            let parentVC = UIKitTest6ViewController()
            let childVC = ChildViewController()

            weakParentVC = parentVC
            weakChildVC = childVC

            parentVC.addChild(childVC)
            parentVC.view.addSubview(childVC.view)
            childVC.didMove(toParent: parentVC)
        }

        XCTAssertNil(weakParentVC, "❌ ParentViewController was not deallocated properly, possible memory leak!")
        XCTAssertNil(weakChildVC, "❌ ChildViewController was not deallocated properly, possible memory leak!")
    }
    
    // MARK: - UIKit 7
    func test_MyViewController_Leaks_1Time7() {
        checkNotificationLeak7()
    }

    private func checkNotificationLeak7() {
        weak var weakVC: UIKitTest7ViewController?

        autoreleasepool {
            let vc = UIKitTest7ViewController()
            weakVC = vc
            vc.loadViewIfNeeded()
        }

        XCTAssertNil(weakVC, "❌ ViewController was not deallocated properly, possible memory leak!")
    }
}
