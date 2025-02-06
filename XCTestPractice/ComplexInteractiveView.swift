//
//  ComplexInteractiveView.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import SwiftUI

struct ComplexInteractiveView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var counter = 0
    @State private var isDarkMode = true
    @State private var brightness: Double = 0.5
    @State private var selectedAge = 18
    @State private var isShowingModal = false
    @State private var isShowingAlert = false
    @State private var items = ["Apple", "Banana", "Cherry"]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Complex Interactive UI")
                    .font(.title)
                    .bold()
                
                // MARK: - LOGIN FORM
                VStack {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .accessibilityIdentifier("usernameField")

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .accessibilityIdentifier("passwordField")

                    Button("Login") {
                        if username == "test" && password == "1234" {
                            isLoggedIn = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityIdentifier("loginButton")
                    
                    if isLoggedIn {
                        Text("Welcome, \(username)!")
                            .accessibilityIdentifier("welcomeMessage")
                    }
                }

                // MARK: - COUNTER
                HStack {
                    Button(action: { counter -= 1 }) {
                        Text("-").font(.largeTitle)
                    }
                    .accessibilityIdentifier("decreaseButton")

                    Text("\(counter)")
                        .font(.largeTitle)
                        .accessibilityIdentifier("counterLabel")

                    Button(action: { counter += 1 }) {
                        Text("+").font(.largeTitle)
                    }
                    .accessibilityIdentifier("increaseButton")
                }

                // MARK: - TOGGLE & SLIDER
                Toggle("Dark Mode", isOn: $isDarkMode)
                    .padding()
                    .accessibilityIdentifier("darkModeToggle")

                Slider(value: $brightness, in: 0...1)
                    .padding()
                    .accessibilityIdentifier("brightnessSlider")

                // MARK: - PICKER & STEPPER
                Stepper("Age: \(selectedAge)", value: $selectedAge, in: 1...100)
                    .padding()
                    .accessibilityIdentifier("ageStepper")

                // MARK: - LIST WITH SWIPE ACTIONS
                List {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                    .accessibilityIdentifier("fruitList")
                }

                // MARK: - BUTTONS FOR ALERT & MODAL
                Button("Show Alert") {
                    isShowingAlert = true
                }
                .alert("Hello!", isPresented: $isShowingAlert) {
                    Button("OK", role: .cancel) {}
                }
                .accessibilityIdentifier("alertButton")

                Button("Show Modal") {
                    isShowingModal = true
                }
                .sheet(isPresented: $isShowingModal) {
                    ModalView()
                }
                .accessibilityIdentifier("modalButton")
            }
            .padding()
            .navigationTitle("Complex UI")
        }
    }
}

struct ModalView: View {
    var body: some View {
        VStack {
            Text("This is a modal view!")
                .font(.title)
                .padding()
                .accessibilityIdentifier("modalText")
        }
    }
}

#Preview {
    ComplexInteractiveView()
}
