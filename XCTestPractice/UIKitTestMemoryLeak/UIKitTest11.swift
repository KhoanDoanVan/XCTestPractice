//
//  UIKitTest11.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

class UIKitTest11ViewController: UIViewController {
    
    var panGesture: UIPanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addPanGesture()
    }

    func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture!)
        
        /// ❌ STRONG CAPTURE OF `self` CAUSES A MEMORY LEAK
        panGesture!.addTarget(self, action: #selector(leakingClosureMethod))
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        print("Pan gesture detected!")
    }

    @objc func leakingClosureMethod() {
        /// ❌ Capturing `self` strongly in a closure, preventing deallocation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("Leaking Closure Executed - \(self)") /// ❌ Strong reference to `self`
        }
    }
    
    deinit {
        print("❌ GestureMemoryLeakViewController deinitialized") // This will NEVER be called due to the leak
    }
}


// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest11ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest11ViewController {
        return UIKitTest11ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest11ViewController, context: Context) {}
}
