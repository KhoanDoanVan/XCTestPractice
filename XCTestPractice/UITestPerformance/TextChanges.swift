//
//  TextChanges.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 6/2/25.
//

import SwiftUI

struct TextChanges: View {
    @State private var labelText = "Hello, World!"

    var body: some View {
        VStack {
            Text(labelText)
                .padding()
            
            Button("Change Text") {
                labelText = "Text Changed!"
            }
            .padding()
        }
    }
}

#Preview {
    TextChanges()
}
