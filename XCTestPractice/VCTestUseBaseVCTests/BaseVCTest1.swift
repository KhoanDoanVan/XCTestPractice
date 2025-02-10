//
//  BaseVCTest1.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

class BaseVCTest1: UIViewController {
    
    var closure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ❌ This creates a retain cycle because `self` is strongly captured
        closure = {
            print("LeakingViewController is doing something...")
            print(self.view) // <- Strong reference to `self`
        }
    }
}


// MARK: - SwiftUI Wrapper for ViewController
struct BaseVCTest1Warpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BaseVCTest1 {
        return BaseVCTest1()
    }

    func updateUIViewController(_ uiViewController: BaseVCTest1, context: Context) {}
}


