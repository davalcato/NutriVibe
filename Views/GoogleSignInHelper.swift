//
//  GoogleSignInHelper.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 4/20/25.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore  // <-- Add this import

class GoogleSignInHelper: ObservableObject {
    @Published var signInResult: Result<GIDGoogleUser, Error>? = nil

    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        guard let presentingVC = UIApplication.shared.windows.first?.rootViewController else { return }

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.signInResult = .failure(error)
                }
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                DispatchQueue.main.async {
                    self.signInResult = .failure(NSError(domain: "SignInError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing user or token"]))
                }
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { _, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.signInResult = .failure(error)
                    } else {
                        self.signInResult = .success(user)
                    }
                }
            }
        }
    }
}

