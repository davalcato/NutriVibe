//
//  AppState.swift
//  NutriVibe
//
//  Created by Ethan Hunt on 1/31/25.
//

import SwiftUI

// Define the AppState class as ObservableObject
class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    // Add more properties here as needed
}


//#Preview {
//    AppState()
//}
