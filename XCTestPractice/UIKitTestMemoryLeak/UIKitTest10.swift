//
//  UIKitTest10.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
class FUIKitTest10ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scheduleTask()
    }

    func scheduleTask() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) { // Capturing `self` strongly
            self.performTask()
        }
    }

    func performTask() {
        print("Task executed")
    }

    deinit {
        print("DelayedViewController deinitialized") // This will never be called due to the leak
    }
}

// MARK: - Successfully ✅
class SUIKitTest10ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scheduleTask()
    }

    func scheduleTask() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.performTask()
        }
    }

    func performTask() {
        print("Task executed")
    }

    deinit {
        print("FUIKitTest10ViewController deinitialized") // Now it will be called
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest10ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest10ViewController {
        return FUIKitTest10ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest10ViewController, context: Context) {}
}

struct SUIKitTest10ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest10ViewController {
        return SUIKitTest10ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest10ViewController, context: Context) {}
}
