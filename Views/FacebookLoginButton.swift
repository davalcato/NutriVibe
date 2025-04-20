//
//  FacebookLoginButton.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 4/20/25.
//

import SwiftUI
import FBSDKLoginKit

struct FacebookLoginButton: UIViewRepresentable {
    func makeUIView(context: Context) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        return button
    }

    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        // Nothing needed here for now
    }
}


#Preview {
    FacebookLoginButton()
}
