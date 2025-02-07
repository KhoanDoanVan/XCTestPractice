//
//  UIKitTest6.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import UIKit
import SwiftUI

class UIKitTest6ViewController: UIViewController {
    var childVC: ChildViewController? // ❌ Strong reference causes memory leak

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let child = ChildViewController()
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.didMove(toParent: self)
        childVC = child // ❌ Retaining childVC causes memory leak
    }
}

class ChildViewController: UIViewController {
    var closure: (() -> Void)? // ❌ Captures self strongly

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        closure = { print(self) } // ❌ Causes retain cycle (self → closure → self)
    }
}

//class ChildViewController: UIViewController {
//    var closure: (() -> Void)?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .lightGray
//
//        closure = { [weak self] in // ✅ Capture self weakly
//            guard let self = self else { return }
//            print(self)
//        }
//    }
//}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest6ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest6ViewController {
        return UIKitTest6ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest6ViewController, context: Context) {}
}
