//
//  UIKitTest4.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

class UIKitTest4ViewController: UIViewController {
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ❌ Memory Leak: Strong reference to self inside the closure
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            print("Timer fired: \(self)")
        }
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest4ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest4ViewController {
        return UIKitTest4ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest4ViewController, context: Context) {}
}
