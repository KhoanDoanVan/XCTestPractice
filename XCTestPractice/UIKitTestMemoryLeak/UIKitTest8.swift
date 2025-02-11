//
//  UIKitTest8.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 10/2/25.
//

import UIKit
import SwiftUI

// MARK: - Failed ❌
class FUIKitTest8ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData() // Call function that makes a network request
    }
    
    func loadData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Problem: `self` is strongly captured inside the closure
            guard let data = data else { return }
            self.handleResponse(data)
        }
        task.resume()
    }
    
    func handleResponse(_ data: Data) {
        print("Data received: \(data)")
    }
    
    deinit {
        print("URLSessionTestViewController deinitialized")
    }
}

// MARK: - Successfully ✅
class SUIKitTest8ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData() // Call function that makes a network request
    }
    
    func loadData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                print("ViewController deallocated before response")
                return
            }
            guard let data = data else { return }
            self.handleResponse(data)
        }
        task.resume()
    }
    
    func handleResponse(_ data: Data) {
        print("Data received: \(data)")
    }
    
    deinit {
        print("FUIKitTest8ViewController deinitialized")
    }
}

// MARK: - SwiftUI Wrapper for ViewController
struct FUIKitTest8ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FUIKitTest8ViewController {
        return FUIKitTest8ViewController()
    }

    func updateUIViewController(_ uiViewController: FUIKitTest8ViewController, context: Context) {}
}

struct SUIKitTest8ViewControllerWarpper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SUIKitTest8ViewController {
        return SUIKitTest8ViewController()
    }

    func updateUIViewController(_ uiViewController: SUIKitTest8ViewController, context: Context) {}
}
