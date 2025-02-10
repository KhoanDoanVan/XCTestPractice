//
//  UIKitTest8.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

class UIKitTest8ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData() // Call function that makes a network request
    }
    
    func loadData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // ❌ Problem: `self` is strongly captured inside the closure
            guard let data = data else { return }
            self.handleResponse(data)
        }
        task.resume()
    }
    
    func handleResponse(_ data: Data) {
        print("Data received: \(data)")
    }
    
    deinit {
        print("URLSessionTestViewController deinitialized ✅")
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct UIKitTest8ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitTest8ViewController {
        return UIKitTest8ViewController()
    }

    func updateUIViewController(_ uiViewController: UIKitTest8ViewController, context: Context) {}
}
