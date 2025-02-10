//
//  UIKitTest10.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

class UIKitTest10ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scheduleTask()
    }

    func scheduleTask() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) { // ❌ Capturing `self` strongly
            self.performTask()
        }
    }

    func performTask() {
        print("Task executed")
    }

    deinit {
        print("❌ DelayedViewController deinitialized") // ❌ This will never be called due to the leak
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest10ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest10ViewController {
        return UIKitTest10ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest10ViewController, context: Context) {}
}
