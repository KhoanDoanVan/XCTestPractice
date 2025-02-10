//
//  UIKitTest9.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

protocol CustomDelegate: AnyObject { // ✅ Always use `AnyObject` to allow weak references
    func didFinishTask()
}

class TaskManager {
    var delegate: CustomDelegate? // ❌ Strong reference (causes a retain cycle)
    
    func startTask() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.delegate?.didFinishTask()
            }
        }
    }
    
    deinit {
        print("TaskManager deinitialized ✅")
    }
}

class UIKitTest9ViewController: UIViewController, CustomDelegate {
    var taskManager = TaskManager() // ❌ Strong reference to TaskManager

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        taskManager.delegate = self // ❌ Retain cycle (VC -> TaskManager -> VC)
        taskManager.startTask()
    }

    func didFinishTask() {
        print("Task completed!")
    }

    deinit {
        print("FirstViewController deinitialized ✅")
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest9ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest9ViewController {
        return UIKitTest9ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest9ViewController, context: Context) {}
}

