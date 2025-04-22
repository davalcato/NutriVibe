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
    
    @StateObject private var googleSignInHelper = GoogleSignInHelper()
    
    // Matching WelcomeView aesthetics
    let gradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 0.2, green: 0.5, blue: 0.3).opacity(0.8),
            Color(red: 0.4, green: 0.7, blue: 0.5).opacity(0.8)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    let buttonColor = Color(red: 0.3, green: 0.7, blue: 0.5)
    let cardBackground = Color(.systemBackground)
    
    var body: some View {
        NavigationView {
            ZStack {
                // Earthy gradient background (matches WelcomeView)
                gradient
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // App icon/header (matching WelcomeView style)
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    // Title
                    Text(loginData.registerUser ? "Create Your Account" : "Welcome Back")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    // Card container (now matches WelcomeView's rounded style)
                    VStack(spacing: 16) {
                        // Email field
                        CustomTextField(
                            icon: "envelope.fill",
                            title: "Email",
                            hint: "example@email.com",
                            value: $loginData.email,
                            isSecure: false,
                            showPassword: .constant(false)
                        )
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        
                        // Password field
                        CustomTextField(
                            icon: "lock.fill",
                            title: "Password",
                            hint: "Enter your password",
                            value: $loginData.password,
                            isSecure: true,
                            showPassword: $loginData.showPassword
                        )
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        
                        // Conditional re-enter password field
                        if loginData.registerUser {
                            CustomTextField(
                                icon: "lock.rotation",
                                title: "Re-enter Password",
                                hint: "Re-enter password",
                                value: $loginData.reEnterPassword,
                                isSecure: true,
                                showPassword: $loginData.showReEnterPassword
                            )
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                        }
                        
                        // Action button
                        Button(action: handleAuthAction) {
                            Text(loginData.registerUser ? "Register" : "Login")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        // Status messages
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
                        
                        // Social login divider
                        Text("or continue with")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.top, 8)
                        
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
                        
                        // Toggle between login/register
                        Button(action: {
                            withAnimation {
                                loginData.registerUser.toggle()
                            }
                        }) {
                            Text(loginData.registerUser ? "Already have an account? Login" : "Don't have an account? Register")
                                .font(.footnote)
                                .foregroundColor(.green)
                                .padding(8)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(cardBackground)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .padding(.horizontal, 24)
                    
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
    
    // MARK: - Action Handlers (unchanged from your original)
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


