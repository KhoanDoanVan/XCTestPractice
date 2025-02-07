//
//  UIKitTest3.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

class UIKitTest3ViewController: UIViewController {
    var closure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ❌ Memory Leak: Self is strongly captured inside the closure
        closure = { print(self) }
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest3ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest3ViewController {
        return UIKitTest3ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest3ViewController, context: Context) {}
}
