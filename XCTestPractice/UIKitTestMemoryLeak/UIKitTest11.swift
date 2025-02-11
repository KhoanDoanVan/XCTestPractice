//
//  UIKitTest11.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
class FUIKitTest11ViewController: UIViewController {
    
    var panGesture: UIPanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addPanGesture()
    }

    func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture!)
        
        /// STRONG CAPTURE OF `self` CAUSES A MEMORY LEAK
        panGesture!.addTarget(self, action: #selector(leakingClosureMethod))
    }
    
    @objc func leakingClosureMethod() {
        /// Capturing `self` strongly in a closure, preventing deallocation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("Leaking Closure Executed - \(self)") /// Strong reference to `self`
        }
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        print("Pan gesture detected!")
    }
    
    deinit {
        print("GestureMemoryLeakViewController deinitialized") // This will NEVER be called due to the leak
    }
}

// MARK: - Successfully ✅
class SUIKitTest11ViewController: UIViewController {
    
    var panGesture: UIPanGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addPanGesture()
    }

    func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture!)
        panGesture!.addTarget(self, action: #selector(safeClosureMethod))
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        print("Pan gesture detected!")
    }

    @objc func safeClosureMethod() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            print("Closure executed safely - \(String(describing: self))")
        }
    }
    
    deinit {
        print("FUIKitTest11ViewController deinitialized ✅") // Now properly called
    }
}


// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest11ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest11ViewController {
        return FUIKitTest11ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest11ViewController, context: Context) {}
}

struct SUIKitTest11ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest11ViewController {
        return SUIKitTest11ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest11ViewController, context: Context) {}
}
