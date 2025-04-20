//
//  LoginViewModel.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 4/20/25.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var reEnterPassword = ""

    @Published var showPassword = false
    @Published var showReEnterPassword = false
    @Published var registerUser = false

    @Published var errorMessage = ""

    func loginUserValid() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }

    func registerUserValid() -> Bool {
        return !email.isEmpty && !password.isEmpty && password == reEnterPassword
    }

    func login(completion: @escaping (Bool) -> Void) {
        // Fake async login simulation (replace with Firebase/Auth/etc.)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(self.email == "test@example.com" && self.password == "password123")
        }
    }

    func register(completion: @escaping (Bool) -> Void) {
        // Fake async register simulation (replace with Firebase/Auth/etc.)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(true) // Simulate success
        }
    }
}


#Preview {
    LoginView(loginData: LoginViewModel())
}

