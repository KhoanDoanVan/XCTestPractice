//
//  ThreeButtonBasic.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 6/2/25.
//

import SwiftUI

struct ThreeButtonsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                print("Button 1 tapped!")
            }) {
                Text("Button 1")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                print("Button 2 tapped!")
            }) {
                Text("Button 2")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                print("Button 3 tapped!")
            }) {
                Text("Button 3")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ThreeButtonsView()
}
