//
//  ContentView.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showViewController = false

    var body: some View {
        VStack {
            Button("Open ViewController") {
                showViewController = true
            }
        }
        .sheet(isPresented: $showViewController) {
            UIKitTest12ViewControllerWarpper()
        }
    }
}

#Preview {
    ContentView()
}
