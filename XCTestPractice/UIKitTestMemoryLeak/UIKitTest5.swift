//
//  UIKitTest5.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

class UIKitTest5ViewController: UIViewController {
    var displayLink: CADisplayLink?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ❌ Memory leak: `self` is strongly retained inside the selector method
        displayLink = CADisplayLink(target: self, selector: #selector(updateUI))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc func updateUI() {
        print("Updating UI: \(self)")
    }
}

//class UIKitTest5ViewController: UIViewController {
//    var displayLink: CADisplayLink?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // ✅ Use a weak proxy to avoid strong retain cycles
//        displayLink = CADisplayLink(target: WeakProxy(target: self), selector: #selector(updateUI))
//        displayLink?.add(to: .main, forMode: .common)
//    }
//
//    @objc func updateUI() {
//        print("Updating UI without memory leak! 🎉")
//    }
//
//    deinit {
//        displayLink?.invalidate() // ✅ Always invalidate the displayLink
//        print("CADisplayLinkFixedViewController deallocated! 🎉")
//    }
//}
//
//// ✅ Weak proxy class to prevent memory leaks
//class WeakProxy: NSObject {
//    weak var target: AnyObject?
//
//    init(target: AnyObject) {
//        self.target = target
//    }
//
//    override func forwardingTarget(for aSelector: Selector!) -> Any? {
//        return target
//    }
//}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest5ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest5ViewController {
        return UIKitTest5ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest5ViewController, context: Context) {}
}
