//
//  NutriVibeApp.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 1/25/25.
//

import SwiftUI

@main
struct NutriVibeApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(appState)
        }
    }
}
