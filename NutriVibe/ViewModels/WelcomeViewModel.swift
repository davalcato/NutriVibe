//
//  WelcomeViewModel.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 1/25/25.
//

import Foundation

class WelcomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var appName: String = NSLocalizedString("NutriVibe", comment: "App name")
    @Published var tagline: String = NSLocalizedString("tagline", comment: "App tagline")
    @Published var nextButtonText: String = NSLocalizedString("next_button", comment: "Next button text")
    
    // MARK: - Navigation
    @Published var isNavigating: Bool = false
    
    func navigateToNextScreen() {
        isNavigating = true
    }
}
