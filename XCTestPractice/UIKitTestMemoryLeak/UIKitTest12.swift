//
//  UIKitTest12.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI
import Combine

class UIKitTest12ViewController: UIViewController {
    var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCombineSubscription()
    }

    func setupCombineSubscription() {
        cancellable = Just("Memory Leak")
            .delay(for: .seconds(5), scheduler: DispatchQueue.main)
            .sink { _ in
                print("Combine Subscription Executed - \(self)")
            }
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest12ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest12ViewController {
        return UIKitTest12ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest12ViewController, context: Context) {}
}
