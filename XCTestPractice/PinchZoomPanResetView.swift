//
//  PinchZoomPanResetView.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import SwiftUI

/// Define the main view for pinch-to-zoom, pan, and reset functionalities
struct PinchZoomPanResetView: View {
    
    /// State variables to manage scaling and positioning
    @State private var scale: CGFloat = 1.0 /// Current scale factor
    @State private var offset: CGSize = .zero /// Current offset for panning
    @State private var lastScaleValue: CGFloat = 1.0 /// Last scale value to calculate scale delta
    @State private var lastOffset: CGSize = .zero /// Last offset value after panning ends
    
    var body: some View {
        
        /// Define the magnification gesture for pinch-to-zoom
        let magnificationGesture = MagnificationGesture()
            .onChanged { value in
                /// Calculate the scale delta since the last update
                let delta = value / self.lastScaleValue
                /// Update the last scale value for the next calculation
                self.lastScaleValue = value
                /// Apply the delta to the current scale, limiting it between 1x and 5x
                let newScale = self.scale * delta
                self.scale = min(max(newScale, 1.0), 5.0) /// Limit the scale between 1x and 5x
            }
            .onEnded { _ in
                /// Reset the last scale value when the gesture ends
                self.lastScaleValue = 1.0
            }
        
        /// Define the drag gesture for panning
        let dragGesture = DragGesture()
            .onChanged { value in
                /// Update the offset based on the current translation and the last offset
                self.offset = CGSize(
                    width: value.translation.width + self.lastOffset.width,
                    height: value.translation.height + self.lastOffset.height
                )
            }
            .onEnded { _ in
                /// Save the last offset when the gesture ends
                self.lastOffset = self.offset
            }
        
        /// Define the double-tap gesture to reset the scale and position
        let doubleTapGesture = TapGesture(count: 2)
            .onEnded {
                /// Animate the reset of scale and offset to default values
                withAnimation {
                    self.scale = 1.0
                    self.offset = .zero
                    self.lastOffset = .zero
                }
            }
        
        /// The content view with gestures applied
        Image("image")
            .resizable()
            .scaledToFit()
            .scaleEffect(scale) /// Apply the current scale factor
            .offset(offset) /// Apply the current offset for panning
            .gesture(
                /// Combine gestures to allow simultaneous recognition
                dragGesture
                    .simultaneously(with: magnificationGesture)
                    .simultaneously(with: doubleTapGesture)
            )
    }
}

#Preview(body: {
    PinchZoomPanResetView()
})
