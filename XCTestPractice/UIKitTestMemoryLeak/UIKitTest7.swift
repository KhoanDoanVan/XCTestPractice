//
//  UIKitTest7.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI
import NotificationCenter

extension Notification.Name {
    static let customNotification = Notification.Name("customNotification")
}

class UIKitTest7ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: .customNotification, object: nil, queue: .main) { notification in
            print("Notification received in \(self)") // ❌ Strong reference to `self`
        }
    }
}

//class FixedClosureViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        NotificationCenter.default.addObserver(forName: .customNotification, object: nil, queue: .main) { [weak self] notification in
//            guard let self = self else { return }
//            print("Notification received in \(self)")
//        }
//    }
//}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest7ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest7ViewController {
        return UIKitTest7ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest7ViewController, context: Context) {}
}
