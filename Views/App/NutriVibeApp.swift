//
//  NutriVibeApp.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 4/17/25.
//

import SwiftUI

@main
struct NutriVibeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}


//#Preview {
//    NutriVibeApp()
//}
