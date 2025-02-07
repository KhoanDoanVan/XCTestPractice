//
//  CapturingClosure.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import SwiftUI

class CapturingClosureViewModel: ObservableObject {
    var onUpdate: (() -> Void)? // Closure that captures `self`

    init() {
        self.onUpdate = {
            print("🟢 ViewModel updated by closure")
            self.doSomething() // 🔥 Strongly capturing `self` (retain cycle)
        }
        print("🟢 MyViewModel initialized")
    }

    func doSomething() {
        print("🔵 Doing some work...")
    }

    deinit {
        print("❌ MyViewModel deallocated") // ❌ This will never print (memory leak!)
    }
}
