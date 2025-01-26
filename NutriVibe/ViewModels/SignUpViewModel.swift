//
//  SignUpViewModel.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 1/25/25.
//

import Foundation

class SignUpViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSigningUp: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: - Methods
    func signUp() {
        // Validate inputs
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        
        // Simulate a sign-up process
        isSigningUp = true
        errorMessage = ""
        
        // TODO: Integrate with Firebase or another backend for actual sign-up
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isSigningUp = false
            print("User signed up with email: \(self.email)")
        }
    }
}
