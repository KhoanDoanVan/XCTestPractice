//
//  UIKitTest9.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
protocol FCustomDelegate: AnyObject {
    func didFinishTask()
}

class FTaskManager {
    var delegate: FCustomDelegate? // Strong reference (causes a retain cycle)
    
    func startTask() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.delegate?.didFinishTask()
            }
        }
    }
    
    deinit {
        print("TaskManager deinitialized")
    }
}

class FUIKitTest9ViewController: UIViewController, FCustomDelegate {
    var taskManager = FTaskManager() // Strong reference to TaskManager

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        taskManager.delegate = self // Retain cycle (VC -> TaskManager -> VC)
        taskManager.startTask()
    }

    func didFinishTask() {
        print("Task completed!")
    }

    deinit {
        print("FirstViewController deinitialized")
    }
}

// MARK: - Successfully ✅
protocol SCustomDelegate: AnyObject { // Use `AnyObject` for weak delegation
    func didFinishTask()
}

class STaskManager {
    weak var delegate: SCustomDelegate? // Use `weak` to prevent retain cycle

    func startTask() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.didFinishTask()
            }
        }
    }
    
    deinit {
        print("TaskManager deinitialized")
    }
}

class SUIKitTest9ViewController: UIViewController, SCustomDelegate {
    var taskManager = STaskManager() // Strong reference to TaskManager

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        taskManager.delegate = self // No retain cycle since `delegate` is weak
        taskManager.startTask()
    }

    func didFinishTask() {
        print("Task completed!")
    }

    deinit {
        print("FUIKitTest9ViewController deinitialized")
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest9ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest9ViewController {
        return FUIKitTest9ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest9ViewController, context: Context) {}
}

struct SUIKitTest9ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest9ViewController {
        return SUIKitTest9ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest9ViewController, context: Context) {}
}
