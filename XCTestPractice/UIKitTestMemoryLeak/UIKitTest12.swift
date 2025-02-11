//
//  UIKitTest12.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI
import Combine

// MARK: - Failed ❌
class FUIKitTest12ViewController: UIViewController {
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

// MARK: - Successfully ✅
class SUIKitTest12ViewController: UIViewController {
    var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCombineSubscription()
    }

    func setupCombineSubscription() {
        cancellable = Just("Memory Leak")
            .delay(for: .seconds(5), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                print("Combine Subscription Executed - \(self)")
            }
    }

    deinit {
        print("FUIKitTest12ViewController deinitialized ✅")
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest12ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest12ViewController {
        return FUIKitTest12ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest12ViewController, context: Context) {}
}

struct SUIKitTest12ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest12ViewController {
        return SUIKitTest12ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest12ViewController, context: Context) {}
}
