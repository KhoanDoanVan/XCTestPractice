//
//  ViewModel.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 7/2/25.
//

import SwiftUI

class MyService {
    var viewModel: MyViewModel? // 🔥 Strong reference to ViewModel

    init() {
        print("🟢 MyService initialized")
    }

    deinit {
        print("❌ MyService deallocated") // This will NEVER print (memory leak!)
    }
}

class MyViewModel: ObservableObject {
    var service: MyService // 🔥 Strong reference to Service

    init() {
        self.service = MyService()
        self.service.viewModel = self // 🔥 Creates a retain cycle!
        print("🟢 MyViewModel initialized")
    }

    deinit {
        print("❌ MyViewModel deallocated") // This will NEVER print (memory leak!)
    }
}
