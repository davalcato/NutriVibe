//
//  LoginView.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 4/10/25.
//

import SwiftUI
import FBSDKLoginKit

struct LoginView: View {
    @ObservedObject var loginData: LoginViewModel
    @EnvironmentObject var appState: AppState
    @State private var showErrorAlert = false
    @State private var showSuccessMessage = false
    @State private var showFailureMessage = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(loginData.registerUser ? "Create Account" : "Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                // Email Field
                CustomTextField(
                    icon: "envelope",
                    title: "Email",
                    hint: "example@example.com",
                    value: $loginData.email,
                    isSecure: false,
                    showPassword: .constant(false)
                )
                .padding(.horizontal, 50)

                // Password Field
                CustomTextField(
                    icon: "lock",
                    title: "Password",
                    hint: "Enter your password",
                    value: $loginData.password,
                    isSecure: true,
                    showPassword: $loginData.showPassword
                )
                .padding(.horizontal, 50)

                // Re-enter Password (only for Register)
                if loginData.registerUser {
                    CustomTextField(
                        icon: "lock",
                        title: "Re-enter Password",
                        hint: "Re-enter your password",
                        value: $loginData.reEnterPassword,
                        isSecure: true,
                        showPassword: $loginData.showReEnterPassword
                    )
                    .padding(.horizontal, 50)
                }

                // Login/Register Button
                Button(action: handleAuthAction) {
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                .alert(isPresented: $showErrorAlert) {
                    Alert(title: Text("Error"), message: Text(loginData.errorMessage), dismissButton: .default(Text("OK")))
                }

                if showSuccessMessage {
                    Text("Registration successful!")
                        .foregroundColor(.green)
                        .padding(.top, 10)
                }

                if showFailureMessage {
                    Text("Registration failed. Please try again.")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }

                // Google & Facebook side-by-side
                HStack(spacing: 20) {
                    Button(action: handleGoogleSignIn) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Google")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                    }

                    FacebookLoginButton()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 50)
                .padding(.top, 10)

                // Toggle login/register mode
                Button(action: {
                    loginData.registerUser.toggle()
                }) {
                    Text(loginData.registerUser ? "Already have an account? Login" : "Don't have an account? Register")
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                }

                Spacer()
            }
            .navigationBarHidden(true)
            .background(
                GeometryReader { _ in
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                }
            )
        }
    }

    private func handleAuthAction() {
        if loginData.registerUser {
            if loginData.registerUserValid() {
                loginData.register { success in
                    DispatchQueue.main.async {
                        if success {
                            showSuccessMessage = true
                            showFailureMessage = false
                            appState.isLoggedIn = true
                        } else {
                            showFailureMessage = true
                            showSuccessMessage = false
                        }
                    }
                }
            } else {
                loginData.errorMessage = "Please make sure all fields are filled and passwords match."
                showErrorAlert = true
            }
        } else {
            if loginData.loginUserValid() {
                loginData.login { success in
                    DispatchQueue.main.async {
                        if success {
                            appState.isLoggedIn = true
                        } else {
                            loginData.errorMessage = "Incorrect email or password."
                            showErrorAlert = true
                        }
                    }
                }
            } else {
                loginData.errorMessage = "Email and password cannot be empty."
                showErrorAlert = true
            }
        }
    }

    private func handleGoogleSignIn() {
        // Add your Google Sign-In logic here
        print("Google Sign-In tapped")
    }
}

#Preview {
    LoginView(loginData: LoginViewModel())
}


