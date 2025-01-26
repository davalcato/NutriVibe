//
//  SignUpView.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 1/25/25.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Properties
    @StateObject private var viewModel = SignUpViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // Email Field
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.horizontal, 20)
            
            // Password Field
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            // Error Message
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal, 20)
            }
            
            // Sign Up Button
            Button(action: {
                viewModel.signUp()
            }) {
                if viewModel.isSigningUp {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            .disabled(viewModel.isSigningUp)
            
            Spacer()
        }
        .padding(.top, 40)
        .navigationTitle("Sign Up")
    }
}

// MARK: - Preview
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
