//
//  LoginView.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 4/20/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var loginData: LoginViewModel
    @EnvironmentObject var appState: AppState
    @State private var showErrorAlert = false
    @State private var showSuccessMessage = false
    @State private var showFailureMessage = false

    // Google Sign-In Helper
    @StateObject private var googleSignInHelper = GoogleSignInHelper()

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.6)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    // Title
                    Text(loginData.registerUser ? "Create Your Account" : "Welcome Back")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 30)

                    // Glassmorphism Card
                    VStack(spacing: 16) {
                        CustomTextField(
                            icon: "envelope.fill",
                            title: "Email",
                            hint: "example@email.com",
                            value: $loginData.email,
                            isSecure: false,
                            showPassword: .constant(false)
                        )

                        CustomTextField(
                            icon: "lock.fill",
                            title: "Password",
                            hint: "Enter your password",
                            value: $loginData.password,
                            isSecure: true,
                            showPassword: $loginData.showPassword
                        )

                        if loginData.registerUser {
                            CustomTextField(
                                icon: "lock.rotation",
                                title: "Re-enter Password",
                                hint: "Re-enter password",
                                value: $loginData.reEnterPassword,
                                isSecure: true,
                                showPassword: $loginData.showReEnterPassword
                            )
                        }

                        // Login/Register Button
                        Button(action: handleAuthAction) {
                            Text(loginData.registerUser ? "Register" : "Login")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }

                        if showSuccessMessage {
                            Text("✅ Registration successful!")
                                .foregroundColor(.green)
                                .transition(.opacity)
                        }

                        if showFailureMessage {
                            Text("❌ Registration failed. Try again.")
                                .foregroundColor(.red)
                                .transition(.opacity)
                        }

                        // Google Sign-In
                        Button(action: handleGoogleSignIn) {
                            HStack(spacing: 12) {
                                Image(systemName: "globe")
                                Text("Sign in with Google")
                            }
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(10)
                        }

                        // Facebook Sign-In
                        FacebookLoginButton()
                            .frame(height: 44)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(10)

                        // Toggle login/register mode
                        Button(action: {
                            withAnimation {
                                loginData.registerUser.toggle()
                            }
                        }) {
                            Text(loginData.registerUser ? "Already have an account? Login" : "Don’t have an account? Register")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                    .shadow(radius: 10)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(loginData.errorMessage), dismissButton: .default(Text("OK")))
            }
            .onReceive(googleSignInHelper.$signInResult) { result in
                guard let result = result else { return }
                
                switch result {
                case .success(_):
                    appState.isLoggedIn = true
                case .failure(let error):
                    loginData.errorMessage = error.localizedDescription
                    showErrorAlert = true
                }
            }
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
        googleSignInHelper.signIn()
    }
}


#Preview {
    LoginView(loginData: LoginViewModel())
        .environmentObject(AppState())
}


