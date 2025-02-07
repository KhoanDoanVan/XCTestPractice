//
//  UIKitTest1.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import SwiftUI
import UIKit

// MARK: - ViewModel (Leaky)
class UIKitTest1ViewModel {
    var onDataUpdate: (() -> Void)? // Retain cycle occurs here
    
    init() {
        print("ViewModel initialized")
    }
    
    deinit {
        print("ViewModel deallocated ❌ (Won't be called if leaked)")
    }
}

// MARK: - ViewController (Leaky)
class UIKitTest1ViewController: UIViewController {
    var viewModel: UIKitTest2ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = UIKitTest2ViewModel()
        
        // Memory leak: Strong reference cycle
        viewModel?.onDataUpdate = {
            self.updateUI()
        }

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        closeButton.frame = CGRect(x: 50, y: 200, width: 200, height: 50)
        view.addSubview(closeButton)
    }

    func updateUI() {
        print("Updating UI")
    }

    @objc func closeView() {
        dismiss(animated: true)
    }

    deinit {
        print("ViewController deallocated ❌ (Won't be called if leaked)")
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest1ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest1ViewController {
        return UIKitTest1ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest1ViewController, context: Context) {}
}
