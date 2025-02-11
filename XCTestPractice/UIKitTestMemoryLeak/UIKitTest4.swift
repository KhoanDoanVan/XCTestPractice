//
//  UIKitTest4.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
class FUIKitTest4ViewController: UIViewController {
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ❌ Memory Leak: Strong reference to self inside the closure
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            print("Timer fired: \(self)")
        }
    }
}

// MARK: - Successfully ✅
class SUIKitTest4ViewController: UIViewController {
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ✅ Avoid Memory Leak: Use [weak self] to prevent retain cycle
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else {
                print("Timer stopped due to self being nil")
                return
            }
            print("Timer fired: \(self)")
        }
    }

    deinit {
        timer?.invalidate()
        print("FUIKitTest4ViewController deinitialized")
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest4ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest4ViewController {
        return FUIKitTest4ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest4ViewController, context: Context) {}
}

struct SUIKitTest4ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest4ViewController {
        return SUIKitTest4ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest4ViewController, context: Context) {}
}
