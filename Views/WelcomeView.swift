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
    @State private var currentPage: Int = 0
    @State private var isAnimating: Bool = false
    
    // Earthy gradient for the top background
    let gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.2, green: 0.5, blue: 0.3).opacity(0.8), Color(red: 0.4, green: 0.7, blue: 0.5).opacity(0.8)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Greenish color for the Next button
    let buttonColor = Color(red: 0.3, green: 0.7, blue: 0.5)
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top 40%: Image with Earthy Gradient Background
                ZStack {
                    gradient
                        .edgesIgnoringSafeArea(.all)
                    
                    // Show different images based on the current slide
                    if currentPage == 0 {
                        Image("Vegetables") // First slide image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, 50)
                            .transition(.opacity.combined(with: .scale(scale: 0.9))) // Fade and scale animation
                    } else {
                        Image("Nutrition") // Second slide image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, 50)
                            .transition(.opacity.combined(with: .scale(scale: 0.9))) // Fade and scale animation
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.4) // 40% of screen height
                
                // Bottom 60%: Rounded Card with Swipeable Content
                VStack(spacing: 20) {
                    // Swipeable Content
                    TabView(selection: $currentPage) {
                        // First Slide
                        VStack(spacing: 10) {
                            Text("Calorie tracking made easy")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .scaleEffect(isAnimating ? 1.0 : 0.9) // Bounce animation
                                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: isAnimating)
                            
                            Text("Just snap a quick photo of your meal and we'll do the rest")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }
                        .tag(0)
                        
                        // Second Slide
                        VStack(spacing: 10) {
                            Text("In-depth nutrition analyses")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .scaleEffect(isAnimating ? 1.0 : 0.9) // Bounce animation
                                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: isAnimating)
                            
                            Text("Get detailed insights into your meals and improve your diet")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }
                        .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default page indicator
                    .frame(height: UIScreen.main.bounds.height * 0.4) // 40% of screen height
                    .onChange(of: currentPage) { _ in
                        isAnimating = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isAnimating = true
                        }
                    }
                    
                    // Interactive Swipe Indicator (3 Dots)
                    HStack(spacing: 10) {
                        ForEach(0..<2) { index in
                            Button(action: {
                                withAnimation {
                                    currentPage = index
                                }
                            }) {
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(currentPage == index ? buttonColor : .gray)
                                    .scaleEffect(currentPage == index ? 1.2 : 1.0) // Scale animation for active dot
                                    .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: currentPage)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    
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
                                .background(buttonColor)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20) // Bring the button closer to the bottom
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.6) // 60% of screen height
                .background(Color(.systemBackground)) // Light background for the card
                .cornerRadius(30, corners: [.topLeft, .topRight]) // Rounded corners at the top
                .shadow(radius: 10) // Add a subtle shadow
            }
            .background(Color(.systemBackground)) // Dark background for the entire screen
            .navigationTitle("") // Hide the navigation bar title
            .navigationBarHidden(true) // Hide the navigation bar
            .onAppear {
                isAnimating = true // Trigger bounce animation on appear
            }
        }
    }
}

// MARK: - Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .preferredColorScheme(.light) // Test light mode
        WelcomeView()
            .preferredColorScheme(.dark) // Test dark mode
    }
}

// MARK: - CornerRadius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    WelcomeView()
}
