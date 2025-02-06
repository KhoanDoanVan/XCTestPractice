//
//  DetailView.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 6/2/25.
//

import SwiftUI

class LeakyViewModel: ObservableObject {
    @Published var count = 0
    
    init() {
        print("✅ LeakyViewModel initialized")
    }
    
    deinit {
        print("❌ LeakyViewModel deinitialized")
    }
}

struct LeakyView: View {
    @StateObject var viewModel = LeakyViewModel()
    
    var body: some View {
        VStack {
            Text("Leaky View - Count: \(viewModel.count)")
            Button("Increment") {
                viewModel.count += 1
            }
        }
    }
}
