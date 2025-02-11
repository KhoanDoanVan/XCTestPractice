//
//  UIKitTest3.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
class FUIKitTest3ViewController: UIViewController {
    var closure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Memory Leak: Self is strongly captured inside the closure
        closure = { print(self) }
    }
}

// MARK: - Successfully ✅
class SUIKitTest3ViewController: UIViewController {
    var closure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Avoid Memory Leak: Use [weak self] to prevent a retain cycle
        closure = { [weak self] in
            guard let self = self else { return }
            print(self)
        }
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest3ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest3ViewController {
        return FUIKitTest3ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest3ViewController, context: Context) {}
}

struct SUIKitTest3ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest3ViewController {
        return SUIKitTest3ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest3ViewController, context: Context) {}
}
