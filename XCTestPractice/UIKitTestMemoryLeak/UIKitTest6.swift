//
//  UIKitTest6.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
class FUIKitTest6ViewController: UIViewController {
    var childVC: FChildViewController? /// Strong reference causes memory leak

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let child = FChildViewController()
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.didMove(toParent: self)
        childVC = child /// Retaining childVC causes memory leak
    }
}

class FChildViewController: UIViewController {
    var closure: (() -> Void)? /// Captures self strongly

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        closure = {
            print(self)
        } /// Causes retain cycle (self → closure → self)
    }
}

// MARK: - Successfully ✅
class SUIKitTest6ViewController: UIViewController {
    weak var childVC: SChildViewController? /// Strong reference causes memory leak

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let child = SChildViewController()
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.didMove(toParent: self)
        childVC = child /// Retaining childVC causes memory leak
    }
}

class SChildViewController: UIViewController {
    var closure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        closure = { [weak self] in // Capture self weakly
            guard let self = self else { return }
            print(self)
        }
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest6ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest6ViewController {
        return FUIKitTest6ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest6ViewController, context: Context) {}
}

struct SUIKitTest6ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest6ViewController {
        return SUIKitTest6ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest6ViewController, context: Context) {}
}
