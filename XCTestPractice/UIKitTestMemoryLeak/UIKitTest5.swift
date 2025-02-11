//
//  UIKitTest5.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
class FUIKitTest5ViewController: UIViewController {
    var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Memory leak: `self` is strongly retained inside the selector method
        displayLink = CADisplayLink(target: self, selector: #selector(updateUI))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc func updateUI() {
        print("Updating UI: \(self)")
    }
}

// MARK: - Successfully ✅
class SUIKitTest5ViewController: UIViewController {
    var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use a weak proxy to avoid strong retain cycles
        displayLink = CADisplayLink(target: WeakProxy(target: self), selector: #selector(updateUI))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc func updateUI() {
        print("Updating UI without memory leak! 🎉")
    }

    deinit {
        displayLink?.invalidate() // Always invalidate the displayLink
        print("CADisplayLinkFixedViewController deallocated! 🎉")
    }
}

// Weak proxy class to prevent memory leaks
class WeakProxy: NSObject {
    weak var target: AnyObject?

    init(target: AnyObject) {
        self.target = target
    }

    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest5ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest5ViewController {
        return FUIKitTest5ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest5ViewController, context: Context) {}
}

struct SUIKitTest5ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest5ViewController {
        return SUIKitTest5ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest5ViewController, context: Context) {}
}
