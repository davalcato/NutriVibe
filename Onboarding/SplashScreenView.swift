//
//  SplashScreenView.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 1/26/25.
//

import SwiftUI

struct SplashScreenView: View {
    // MARK: - State Properties
    @State private var isActive: Bool = false
    @State private var logoAnimation: Bool = false
    
    // MARK: - Body
    var body: some View {
        Group {
            if isActive {
                WelcomeView() // Transition to WelcomeView
            } else {
                ZStack {
                    // Background Color
                    Color(.systemBackground)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        // App Logo
                        Image("NutriVibe") // Replace with your app logo asset
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                            .opacity(logoAnimation ? 1 : 0) // Fade in animation
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.5)) {
                                    self.logoAnimation = true // Trigger logo animation
                                }
                                
                                // Automatically navigate to WelcomeView after 4 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    withAnimation {
                                        self.isActive = true // Transition to WelcomeView
                                    }
                                }
                            }
                        
                        // App Name
                        Text("NutriVibe")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .preferredColorScheme(.light) // Test light mode
        SplashScreenView()
            .preferredColorScheme(.dark) // Test dark mode
    }
}
