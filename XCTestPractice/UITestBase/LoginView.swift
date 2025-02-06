//
//  LoginView.swift
//  XCTestPractice
//
//  Created by Đoàn Văn Khoan on 5/2/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    @State private var showError = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()

          

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .accessibilityIdentifier("passwordField")

            Button("Login") {
                if username == "testuser" && password == "password123" {
                    isLoggedIn = true
                    showError = false
                } else {
                    showError = true
                }
            }
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("loginButton")

            if isLoggedIn {
                Text("Welcome, \(username)!")
                    .font(.headline)
                    .accessibilityIdentifier("welcomeMessage")
            }

            if showError {
                Text("Invalid credentials. Please try again.")
                    .foregroundColor(.red)
                    .accessibilityIdentifier("errorMessage")
            }
        }
        .padding()
    }
    
    var loginButton: some View {
        TextField("Username", text: $username)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .accessibilityIdentifier("usernameField")
    }
}

#Preview {
    LoginView()
}
