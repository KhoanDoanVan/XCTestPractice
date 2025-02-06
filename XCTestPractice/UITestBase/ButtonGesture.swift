//
//  ButtonGesture.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import SwiftUI

struct ButtonGesture: View {
    @State private var buttonPosition = CGSize.zero
    @State private var buttonColor = Color.red
    
    var body: some View {
        VStack {
            Text("Drag the button and click to change color!")
                .padding()

            Button(action: {
                // Change color on click
                withAnimation {
                    buttonColor = buttonColor == .red ? .blue : .red
                }
            }) {
                Text("Click Me!")
                    .padding()
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .offset(buttonPosition)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Move the button based on drag
                        buttonPosition = value.translation
                    }
                    .onEnded { _ in
                        // Optionally, you can do something when the drag ends
                    }
            )
            .animation(.easeInOut, value: buttonPosition) // Smooth animation for drag
        }
    }
}

#Preview(body: {
    ButtonGesture()
})
