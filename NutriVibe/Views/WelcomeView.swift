//
//  WelcomeView.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 1/25/25.
//

import SwiftUI

struct WelcomeView: View {
    // MARK: - Properties
    @StateObject private var viewModel = WelcomeViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // App Logo
                Image("NutriVibe") // Replace with your app logo asset
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 50)
                
                // App Name
                Text(viewModel.appName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                // Tagline
                Text(viewModel.tagline)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                // Next Button
                NavigationLink(destination: SignUpView(), isActive: $viewModel.isNavigating) {
                    Button(action: {
                        viewModel.navigateToNextScreen()
                    }) {
                        Text(viewModel.nextButtonText)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .background(Color(.systemBackground)) // Adapts to light/dark mode
            .navigationTitle("") // Hide the navigation bar title
            .navigationBarHidden(true) // Hide the navigation bar
        }
    }
}

#Preview {
    WelcomeView()
}
