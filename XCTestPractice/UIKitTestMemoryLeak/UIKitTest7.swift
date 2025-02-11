//
//  UIKitTest7.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI
import NotificationCenter

// MARK: - Failed ❌
extension Notification.Name {
    static let customNotification = Notification.Name("customNotification")
}

class FUIKitTest7ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: .customNotification, object: nil, queue: .main) { notification in
            print("Notification received in \(self)") // Strong reference to `self`
        }
    }
}

// MARK: - Successfully ✅
class SUIKitTest7ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: .customNotification, object: nil, queue: .main) { [weak self] notification in
            guard let self = self else { return }
            print("Notification received in \(self)")
        }
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest7ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest7ViewController {
        return FUIKitTest7ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest7ViewController, context: Context) {}
}

struct SUIKitTest7ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest7ViewController {
        return SUIKitTest7ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest7ViewController, context: Context) {}
}
