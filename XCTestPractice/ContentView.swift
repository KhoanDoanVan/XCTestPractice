//
//  ContentView.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showLeakyView = false
    
    var body: some View {
        VStack {
            Button("Show Leaky View") {
                showLeakyView.toggle()
            }
            .sheet(isPresented: $showLeakyView) {
                LeakyView()
            }
        }
    }
}

#Preview {
    ContentView()
}
